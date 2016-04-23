class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.mgt_rpts == 'Y'
      can :manage, ManagementReport
    end
    if current_user.sal3_batch_req == 'Y'
      can :manage, Sal3BatchRequest
    end
    if current_user.unicorn_updates == 'Y'
      can :manage, UnicornUpdate
    end
end
