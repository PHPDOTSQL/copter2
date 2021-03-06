module Admin
  class BaseController < ApplicationController
    before_filter :check_admin_manager, :except => [:destroy]
    before_filter :check_admin, :only => [:destroy]
  
    def index
    end
    
    protected

      def check_admin_manager
        unless current_user.is_admin? || current_user.has_role?('Manager')
          flash[:alert] = "Not Authorized!"
          redirect_to root_path
          return
        end
      end
      
      def check_admin
        unless current_user.is_admin?
          flash[:alert] = "Not Authorized!"
          redirect_to root_path
          return
        end
      end
  end
end