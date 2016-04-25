class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= AuthorizedUser.new
    
    if current_user.mgt_rpts == 'Y'
      can :manage, ManagementReport
    end
    if current_user.sal3_batch_req == 'Y'
      can :manage, Sal3BatchRequest
    end
    if current_user.unicorn_updates == 'Y'
      can :manage, BatchRecordUpdate
    end
  end
end
