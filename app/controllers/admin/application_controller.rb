module Admin
    class ApplicationController < ActiveAdmin::BaseController
      before_action :authenticate_admin_user!
  
      private
  
      def authenticate_admin_user!
        authenticate_admin_user!  # Devise authentifie les admin_users
        redirect_to new_admin_user_session_path unless current_admin_user
      end
  
      def current_admin_user
        super  # Devise fournit cette méthode pour le modèle AdminUser
      end
    end
  end
  