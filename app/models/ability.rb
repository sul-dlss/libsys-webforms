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
    alias_action :queue, :completed, :recent, to: :read
    alias_action :menu, to: :read
    alias_action :activate, :deactivate, :run_tests, to: :manage
  end

  def assign_basic_permission
    can :manage, Ckey2bibframe
  end

  def assign_user_permission
    can :manage, BatchRecordUpdate
  end

  def assign_staff_permission(current_user)
    can :manage, AccessionNumberUpdate if /A|Y/ =~ current_user.accession_number
    can %i[read generate_number generate_number_form], AccessionNumber if /A|Y/ =~ current_user.accession_number
    can %i[read create destroy add_batch], DigitalBookplatesBatch if /A|Y/ =~ current_user.digital_bookplates
    can :manage, ManagementReport if /A|Y/ =~ current_user.mgt_rpts
    can %i[create read], Sal3BatchRequestsBatch if /A|Y/ =~ current_user.sal3_batch_req
    can %i[read update download], Sal3BatchRequestsBatch if /A|Y/ =~ current_user.sal3_breq_edit
    can :create, UserloadRerun if /A|Y/ =~ current_user.userload_rerun
    can :read, EdiInvoice if /Y/ =~ current_user.edi_inv_view
    can :manage, EdiInvoice if /A|Y/ =~ current_user.edi_inv_manage
    can :manage, EdiErrorReport if /A|Y/ =~ current_user.edi_inv_manage
    can :read, Package if /A|Y/ =~ current_user.package_manage
    can :read, PackageFile if /A|Y/ =~ current_user.package_manage
  end

  def assign_admin_permission(current_user)
    can :manage, AccessionNumber if /A/ =~ current_user.accession_number
    app = AuthorizedUsersController.helpers.administrator_apps(current_user)
    can :manage, AuthorizedUser if app.any?
    can :delete_batch, DigitalBookplatesBatch if /A/ =~ current_user.digital_bookplates
    can %i[manage list_transfer_logs], Package if /A/ =~ current_user.package_manage
    can :read, VndRunlog if /A/ =~ current_user.package_manage
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
