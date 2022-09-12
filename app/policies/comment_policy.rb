# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(stauts: 'approved')
      end
    end
  end
end
