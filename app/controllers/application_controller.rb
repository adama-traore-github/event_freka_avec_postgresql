class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path  # Redirige vers le tableau de bord admin après connexion
    else
      profile_path  # Redirige vers la page de profil après connexion pour les utilisateurs normaux
    end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path  # Redirige vers le tableau de bord admin après inscription
    else
      profile_path  # Redirige vers la page de profil après inscription pour les utilisateurs normaux
    end
  end

  
end
