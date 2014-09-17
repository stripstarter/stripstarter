module Stripstarter::CampaignStateMachine
  def self.included(base)
    base.class_eval do
      state_machine :status, :initial => :inactive do

        state :active, value: 'active'
        state :inactive, value: 'inactive'
        state :completed, value: 'completed'
        state :canceled, value: 'canceled'

        event :activate do
          transition :inactive => :active
        end
        event :deactive do
          transition :active => :inactive
        end
        event :complete do
          transition :active => :completed
        end
        event :cancel do
          transition [:active, :inactive, :completed] => :canceled
        end
        event :renew do
          transition :canceled => :active
        end
      end
    end
  end
end