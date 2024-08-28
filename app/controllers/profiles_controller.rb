class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :authorize_user
  
    def show
      @events = @user.events
      
    end
  
    private
  
    def set_user
      @user = current_user
    end

    # Vérifie si l'utilisateur courant est autorisé à accéder à la page
    def authorize_user
      redirect_to root_path, alert: 'Vous n\'avez pas l\'autorisation d\'accéder à cette page.' unless current_user == @user
    end
  end
  