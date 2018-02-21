# Class to manage the current user's ability to access views
class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AuthorizedUser.new
    assign_staff_permission(current_user)
    assign_admin_permission(current_user)
    assign_basic_permission
    assign_user_permission if current_user
    assign_batch_permission if /A|Y/ =~ current_user.unicorn_updates
  end

  def assign_basic_permission
    can :manage, Ckey2bibframe
  end

  def assign_user_permission
    can :manage, BatchRecordUpdate
  end

  def assign_staff_permission(current_user)
    can :manage, ManagementReport if /A|Y/ =~ current_user.mgt_rpts
    can :create, Sal3BatchRequestsBatch if /A|Y/ =~ current_user.sal3_batch_req
    can :create, UserloadRerun if /A|Y/ =~ current_user.userload_rerun
    can %i[read update], Sal3BatchRequestsBatch if /A|Y/ =~ current_user.sal3_breq_edit
  end

  def assign_admin_permission(current_user)
    app = AuthorizedUsersController.helpers.authorized_apps(current_user)
    can :manage, AuthorizedUser if app.any?
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
