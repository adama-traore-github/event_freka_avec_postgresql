class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :join]
  before_action :set_event, only: [:show, :edit, :update, :join]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @events = Event.all
  end

  def show
  end

    # Action pour initialiser un nouveau formulaire d'événement

  def new
    @event = current_user.events.build
  end
  
    # Action pour créer un nouvel événement
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'L\'événement a été créé avec succès.'
    else
      render :new
    end
  end

  def edit
  end

    # Action pour mettre à jour un événement existant
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'L\'événement a été mis à jour avec succès.'
    else
      render :edit
    end
  end

    # Action pour rejoindre un événement
  def join
    if @event.price > 0
      # Redirection vers la page de paiement
      redirect_to new_payment_path(amount: @event.price, event_id: @event.id)
    else
      # Inscription automatique à l'événement
      if current_user.attendances.exists?(event_id: @event.id)
        flash[:notice] = 'Vous êtes déjà inscrit à cet événement.'
      else
        current_user.attendances.create!(event: @event)
        flash[:notice] = 'Vous avez rejoint l\'événement avec succès.'
      end
      redirect_to @event
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    # Vérifie si l'utilisateur actuel est le créateur de l'événement
    unless @event.user == current_user
      redirect_to @event, alert: 'Vous n\'êtes pas autorisé à modifier cet événement.'
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end
end
