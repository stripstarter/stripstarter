module CampaignStateMachine
  def self.included(base)
    base.class_eval do
      state_machine :status, :initial => :inactive do

        state :active, value: 'active'
        state :inactive, value: 'inactive'
        state :completed, value: 'completed'
        state :failed, value: 'failed'

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
          transition [:active, :inactive, :completed] => :failed
        end
        event :renew do
          transition :failed => :active
        end
      end
    end
  end
end