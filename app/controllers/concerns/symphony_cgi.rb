##
# Module to construct URL from given params and script name
#  and connect to the Symphony cgi script to run the report
##
module SymphonyCgi
  include EndowFundsParams
  include ShelfSelectionParams

  def request_conn(script, cgi_params)
    @request_conn ||= begin
      request_url = request_url(script, cgi_params)
      Rails.logger.warn("request_url: #{request_url}")

      Faraday.new headers: { accept_encoding: 'none' } do |conn|
        conn.get(request_url)
      end
    rescue Faraday::Error => e
      empty_response(e)
    end
  end

  private

  def request_url(script, cgi_params)
    "#{[Settings.symphony_cgi_url, script].join('/')}?#{query(cgi_params)}"
  end

  def query(cgi_params)
    cgi_params.keep_if { |_, v| v.present? }
    URI.encode_www_form(cgi_params.to_h)
  end

  def empty_response(error = nil)
    Rails.logger.warn("HTTP GET for SymphonyCgi failed with: #{error}")
    NullResponse.new
  end
end
