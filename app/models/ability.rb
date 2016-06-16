# Class to manage the current user's ability to access views
class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AuthorizedUser.new
    can :manage, ManagementReport if current_user.mgt_rpts == 'Y'
    can :manage, Sal3BatchRequestsBatch if current_user.sal3_batch_req == 'Y'
    assign_batch_permission if current_user.unicorn_updates == 'Y'
  end

  def assign_batch_permission
    can :manage, BatchRecordUpdate
    can :manage, ChangeItemType
    can :manage, ChangeCurrentLocation
    can :manage, ChangeHomeLocation
    can :manage, WithdrawItem
    can :manage, TransferItem
  end
end
