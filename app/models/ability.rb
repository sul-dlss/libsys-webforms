# Class to manage the current user's ability to access views
class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AuthorizedUser.new
    can :manage, ManagementReport if current_user.mgt_rpts == 'Y'
    can :manage, Sal3BatchRequest if current_user.sal3_batch_req == 'Y'
    can :manage, BatchRecordUpdate if current_user.unicorn_updates == 'Y'
    can :manage, ChangeItemType if current_user.unicorn_updates == 'Y'
  end
end
