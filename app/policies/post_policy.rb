# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :current_user, :post

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if current_user.admin?
        scope.all
      else
        scope.where(stauts: 'approved')
      end
    end
  end

  def initialize(current_user, post)
    @current_user = current_user
    @post = post
  end

  def new
    current_user.present?
    # return  true
  end

  def show
    true
  end

  def index
    current_user.present? || post.user
  end

  def create
    current_user.admin? || current_user.present?
  end

  def update
    current_user.present? || post.user
  end

  def edit
    current_user.present? || post.user
  end

  def delete
    post.user || current_user.admin? || current_user.moderator?
  end

  def recent
    post.user || current_user.admin? || current_user.moderator?
  end
end
