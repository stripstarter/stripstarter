class Campaign < ActiveRecord::Base
  include CampaignStateMachine

  has_many :campaign_feature_joins
  has_many :features, through: :campaign_feature_joins

  # Fetch all associated performers
  has_many :performances
  has_many :users, through: :performances

  # Fetch all associated pledgers
  has_many :pledges
  has_many :users, through: :pledges

  # Refactor into Pledge.join(:user).where('campaign_id = ? AND role = ?')
  def performers
    Performance
      .where('campaign_id = ?', id)
      .map(&:user)
      .select{ |user| user.performer? }
  end

  # Refactor into Pledge.join(:user).where('campaign_id = ? AND role = ?')
  def pledgers
    Pledge
      .where('campaign_id = ?', id)
      .map(&:user)
      .select { |user| user.pledger? }
  end
  
end
