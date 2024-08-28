class UserMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      @url  = 'https://etp4a.com'  # Assurez-vous que la chaîne est correctement terminée
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
  end
  