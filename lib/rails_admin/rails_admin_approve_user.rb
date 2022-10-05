# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      # common config for custom actions
      class AproveUser < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do #	this is for specific record
          true
        end
        register_instance_option :pjax? do
          false
        end
        register_instance_option :visible? do
          authorized? 		# This ensures the action only shows up for the right class
        end

        register_instance_option :only do
          User
        end
        register_instance_option :link_icon do
          'icon-user'
        end

        register_instance_option :controller do
          proc do
            @object.update_attribute(:confirmed_at, Time.zone.now.getutc)
            flash[:notice] = 'User approved Successfully.'
            redirect_to back_or_index
          end
        end
      end
    end
  end
end
