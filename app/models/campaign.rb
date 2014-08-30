class Campaign < ActiveRecord::Base
  include Stripstarter::CampaignStateMachine
  # States: active, inactive, completed, failed


  ################
  # Associations #
  ################

  has_many :campaign_feature_joins
  has_many :features, through: :campaign_feature_joins

  has_many :performances
  has_many :performers, through: :performances

  has_many :pledges
  has_many :pledgers, through: :pledges

  def users
    pledgers + performers
  end

  ##########
  # Scopes #
  ##########

  def self.top(num = nil)
    _num ||= 5
    includes(:pledges).all.sort_by(&:amount).first(_num)
  end

  scope :newest, lambda { order("campaigns.created_at ASC") }

  #############
  # Searching #
  #############

  after_save :load_into_soulmate

  def load_into_soulmate
    loader = Soulmate::Loader.new("campaign")
    loader.add({
      "term" => name,
      "id" => id,
      "url" => Rails.application.routes.url_helpers.campaign_path(self)})
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('campaign').matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "label" => "campaign",
        "value" => match["term"],
        "url" => match["url"]
      }
    end
  end

  #############

  def amount
    pledges.collect do |pledge|
      pledge.amount.to_i
    end.inject(:+)
  end
  
end
