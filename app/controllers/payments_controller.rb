class PaymentsController < ApplicationController
  def new
    @event_id = params[:event_id]  
    @event = Event.find_by(id: @event_id)


    # Si l'événement n'est pas trouvé, redirige vers la page d'accueil avec un message d'alerte
    if @event.nil?
      redirect_to root_path, alert: 'Événement non trouvé.'
    else
      @amount = @event.price # Laisser l'amount en dollars
    end
  end

  def create
    
    amount = params[:amount].to_f # Garder en dollars ici

        # Récupère le token Stripe pour traiter le paiement
    stripe_token = params[:stripeToken]

    if amount <= 0
      flash[:notice] = "Vous avez rejoint l'événement gratuitement."
      redirect_to event_path(params[:event_id])
      return
    end

        # Vérifie si le token Stripe est absent, indiquant des détails de paiement invalides
    if stripe_token.blank?
      flash[:alert] = "Invalid payment details"
      redirect_to new_payment_path
      return
    end

    begin
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

            # Crée la transaction de paiement avec Stripe
      charge = Stripe::Charge.create(
        amount: (amount * 100).to_i, # Conversion en cents pour Stripe
        currency: 'usd',
        source: stripe_token,
        description: 'Payment for event'
      )
      flash[:notice] = "Payment successful"
    rescue Stripe::CardError => e
      flash[:alert] = e.message
    end

    redirect_to event_path(params[:event_id]) # Redirection vers l'événement après paiement
  end
end
