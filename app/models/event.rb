class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances
  has_many :participants, through: :attendances, source: :user

  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :duration_multiple_of_five
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }

  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,  # Permet 0 comme valeur valide
    less_than_or_equal_to: 1000   # Limite le prix à 1000
  }

  validates :location, presence: true

  def end_date
    start_date + duration.minutes if start_date && duration
  end


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "duration", "id", "location", "price", "start_date", "title", "updated_at", "user_id"]
  end

  private

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date.present? && start_date < DateTime.now
  end

  def duration_multiple_of_five
    errors.add(:duration, "must be a multiple of 5") if duration.present? && duration % 5 != 0
  end
end
