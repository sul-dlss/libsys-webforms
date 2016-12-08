# asychronous processing for shelf selection symphony call
class ShelfSelectionJob < ActiveJob::Base
  include SymphonyCgi
  queue_as :default

  def perform(*args)
    request_conn(args[0], args[1])
  end
end
