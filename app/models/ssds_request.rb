# Create the SSDS Request model
class SsdsRequest
  include ActiveModel::Model

  attr_accessor :affiliation, :call_no_in, :dataset_type, :notes, :department, :name, :phone, :referer, :sponsor,
                :sunet, :title_in, :unicorn_id_in

  validates :call_no_in, :title_in, :unicorn_id_in, presence: true

  def affiliations
    %w(Other Faculty Graduate Staff Undergraduate)
  end

  def departments
    [
      'Other',
      'Anthropology',
      'Business',
      'Communication',
      'Computer Science',
      'Economics',
      'Education',
      'Engineering',
      'History',
      'Human Biology',
      'International Relations',
      'Law',
      'Medicine',
      'Political Science',
      'Psychology',
      'Public Policy',
      'Sociology'
    ]
  end

  def datasets
    %w[Other TAPE ICPSR ROPER]
  end

  def dataset_default
    case call_no_in
    when /TAPE/
      'TAPE'
    when /ICPSR/
      'ICPSR'
    when /ROPER/
      'ROPER'
    else
      'Other'
    end
  end
end
