# nodoc: Autogenerated
module ApplicationHelper
  def accession_menu_button
    link_to button_tag(
      'Back',
      id: 'accession-num-menu',
      class: 'btn btn-md btn-default btn-full'
    ), '/accession_number_updates'
  end

  def restrict_to_development_or_test?
    true if Rails.env.local?
  end

  def restrict_to_production?
    true if Rails.env.production?
  end
end
