class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :stripe_customer, presence: true, if: :requires_payment?


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "event_id", "id", "stripe_customer_id", "updated_at", "user_id"]
  end


  def self.ransackable_associations(auth_object = nil)
    ["event", "user"]
  end


  private

  def requires_payment?
    event.price > 0
  end
  
end
