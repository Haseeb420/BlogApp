# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.all
    end
  end

  def reply?
    user.present?
  end
end
