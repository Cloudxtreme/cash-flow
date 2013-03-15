class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :admin
      can :manage, :all
    else
      can :view, :silver if user.is? :silver
      can :view, :gold if user.is? :gold
      can :view, :platinum if user.is? :platinum
    end
  end
end