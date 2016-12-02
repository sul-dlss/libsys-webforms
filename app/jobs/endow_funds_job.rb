# asychronous processing for endowed funds symphony call
class EndowFundsJob < ActiveJob::Base
  include EndowFundsParams
  include SymphonyCgi
  queue_as :default

  def perform(*args)
    request_conn(args[0], args[1])
  end
end
