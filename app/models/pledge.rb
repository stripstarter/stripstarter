class Pledge < ActiveRecord::Base

  belongs_to :pledger
  belongs_to :campaign

  state_machine :status, initial: :pending do

    state :pending, value: "pending"        # User clicks "pledge"
    state :active, value: "active"          # User goes through checkout page
    state :completed, value: "completed"    # Card is charged successfully
    state :canceled, value: "canceled"      # User cancels pledge
    state :declined, value: "declined"      # Card is declined; Stripe::CardError

    event :activate do
      transition [:pending, :canceled] => :active
    end
    event :complete do
      transition :pending => :completed
    end
    event :decline do
      transition [:pending, :active] => :declined
    end
    event :cancel do
      transition [:pending, :active] => :canceled
    end
  end

  scope :pending, ->() { where(status: "pending") }
  scope :active, ->() { where(status: "active") }
  scope :completed, ->() { where(status: "completed") }
  scope :canceled, ->() { where(status: "canceled") }
  scope :declined, ->() { where(status: "declined") }
end
