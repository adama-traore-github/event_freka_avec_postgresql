class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
    # Méthode pour spécifier les attributs qui peuvent être recherchés avec Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
