# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(stauts: "approved")
      end
    end
  end

  def new?
    user.present?
    # return  true
  end

  def show?
    true
  end

  def index?
    user.present? || post.user
  end

  def create?
    user.admin? || user.present?
  end

  def update?
    user.present? || post.user
  end

  def edit?
    user.present? && user == record.user
  end

  def destroy?
    user == record.user || user.admin? || user.moderator?
  end

  def recent
    user == record.user || user.admin? || user.moderator?
  end
end
