##
# Module to construct URL from given params and script name
#  and connect to the Symphony cgi script to run the report
##
module SymphonyCgi
  extend ActiveSupport::Concern
  include EndowFundsParams
  include ShelfSelectionParams

  def request_conn(script, cgi_params)
    conn = Faraday.new(url: "#{Settings.symphony_cgi_url}#{script}") do |symphony|
      symphony.request  :url_encoded             # form-encode POST params
      symphony.response :logger                  # log requests to STDOUT
      symphony.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    conn.get(hash_to_query(cgi_params))

  rescue Faraday::SSLError, Faraday::Error::ConnectionFailed
    NullResponse.new
  end

  def hash_to_query(cgi_params)
    u = URI.encode_www_form(cgi_params)
    u.split('&').select { |param| param =~ /=./ }.join('&')
  end
end
