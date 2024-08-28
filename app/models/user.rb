class User < ApplicationRecord
  # Ajoutez les modules Devise requis
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  
  
  
         # Associations
  has_many :events, foreign_key: 'user_id', class_name: 'Event'
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  # Validations
  validates :email, presence: true, uniqueness: true
 

  # Callbacks
  after_create :send_welcome_email

  
  
  # Méthode pour spécifier les attributs qui peuvent être recherchés avec Ransack
  def self.ransackable_associations(auth_object = nil)
    ["attendances", "attended_events", "events"]
  end


    # Méthode pour spécifier les associations qui peuvent être recherchées avec Ransack
    def self.ransackable_attributes(auth_object = nil)
      ["confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "description", "email", "encrypted_password", "failed_attempts", "first_name", "id", "last_name", "last_sign_in_at", "last_sign_in_ip", "locked_at", "remember_created_at", "role", "sign_in_count", "unconfirmed_email", "unlock_token", "updated_at"]
    end

  def admin?
    self.role == 'admin'
  end

  

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
