# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      class UsersActions < RailsAdmin::Config::Actions::Base
        register_instance_option :member do #	this is for specific record
          true
        end
        register_instance_option :pjax? do
          false
        end
        register_instance_option :visible? do
          authorized?
        end
      end

      class EnableUser < UsersActions
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :only do
          User
        end
        register_instance_option :link_icon do
          "fa fa-paper-plane"
        end
        register_instance_option :http_methods do
          %i[get post]
        end
        register_instance_option :controller do
          proc do
            # call model.method here
            User.approved_user
            flash[:notice] = "Did custom action on #{@object.name}"
            redirect_to back_or_index
          end
        end
      end
    end
  end
end
