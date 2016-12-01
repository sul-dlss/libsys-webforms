require 'rails_helper'

RSpec.describe EndowFundsJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { EndowFundsJob.perform_later('endow_rpt.cgi', email: 'test@stanford.edu') }

  it 'queues the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in the default queue' do
    expect(EndowFundsJob.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    # how to test request_conn(args[0], args[1])?
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
