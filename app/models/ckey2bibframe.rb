# SSH to Symphony and run a catalogdump on a ckey
class Ckey2bibframe
  include OperatingSystem
  include ActiveModel::Model
  include ActiveModel::Validations
  attr_accessor :ckey, :baseuri, :marcxml
  validates :ckey, numericality: { message: ': You must enter a known ckey!' }

  def convert
    symphony_ssh = "ssh #{Settings.symphony_user}@#{Settings.symphony_host}"
    symphony_env = "source #{Settings.symphony_env}"
    catalogdump = "echo #{ckey} | #{Settings.symphony_catalogdump}"

    jar = 'lib/xform-marc21-to-xml-jar-with-dependencies.jar'
    java_command = "java -Djava.security.egd=file:/dev/../dev/urandom -cp #{jar} edu.stanford.MarcToXMLStream"

    "#{symphony_ssh} '#{symphony_env} && #{catalogdump}' | #{java_command}"
  end

  def marc21_to_xml
    begin
      marcxml = execute_command(convert).force_encoding('UTF-8')
    rescue => e
      Rails.logger.warn('Unable to connect to Symphony via SSH.')
      Rails.logger.error(e)
    end
    marcxml_file.write(marcxml)
    Nokogiri::XML(marcxml, &:noblanks)
  end

  def marcxml_to_bibframe
    marcxml_file.read
    bf2_xsl = 'loc_marc2bibframe2/xsl/marc2bibframe2.xsl'
    command = "xsltproc --stringparam baseuri #{baseuri} #{bf2_xsl} #{@marcxml_file.path}"
    bibframe = execute_command(command).force_encoding('UTF-8')
    marcxml_file.close
    marcxml_file.delete
    Nokogiri::XML(bibframe, &:noblanks)
  end

  def marcxml_file
    @marcxml_file ||= Tempfile.new("#{ckey}.xml")
  end
end
