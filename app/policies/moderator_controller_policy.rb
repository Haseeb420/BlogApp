class ModeratorControllerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(role:'moderator`')
    end
  end

  def index
    user.moderator?
  end
end
