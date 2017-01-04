# Class to manage the current user's ability to access views
class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AuthorizedUser.new
    can :manage, ManagementReport if current_user.mgt_rpts == 'Y'
    can :create, Sal3BatchRequestsBatch if current_user.sal3_batch_req == 'Y'
    can :create, UserloadRerun if current_user.userload_rerun == 'Y'
    can [:read, :update], Sal3BatchRequestsBatch if current_user.sal3_breq_edit == 'Y'
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
