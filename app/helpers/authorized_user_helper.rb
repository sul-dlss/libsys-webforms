#######
#  Module for AuthorizedUser
#######
module AuthorizedUserHelper
  # get column names for user which contains "A"
  def authorized_apps(user)
    authorized_apps = []
    user.attributes.each do |k, v|
      authorized_apps.push(k) if v == 'A'
    end
    authorized_apps
  end

  def apps_translation(app)
    Constants::AUTHORIZED_USER_APPS.fetch(app)
  end
end
