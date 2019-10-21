# Preview all emails at http://localhost:3000/rails/mailers/ssds_request/request
class SsdsRequestPreview < ActionMailer::Preview
  def request
    WebformsMailer.ssds_request(SsdsRequest.new(ssds_request_params))
  end

  private

  def ssds_request_params
    {
      unicorn_id_in: '510163',
      name: 'Jean Grey',
      phone: '650-123-4567',
      sunet: 'sunet_id',
      dataset_type: 'TAPE',
      department: 'Sociology',
      affiliation: 'Staff',
      sponsor: 'Professor X',
      call_no_in: 'TAPE NO. AS1999 ETC',
      notes: 'note'
    }
  end
end
