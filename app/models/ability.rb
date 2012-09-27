class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read,:search,:tab,:tag,:more_solutions,:more_comments],Idea
    can :show,User
    can :show,Topic
    can :show,Tag
    if user
      can [:promotion,:create,:update,:favoriate,:unfavoriate,:handle], Idea
      can :manage, Comment
      can [:create,:update,:destroy], Solution
      can :manage, Vote
      can :manage, Message
    end
  end
end
