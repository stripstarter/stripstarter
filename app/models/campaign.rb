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

  def self.top(num = 5)
    includes(:pledges).all.sort_by(&:amount).last(num).reverse
  end

  scope :newest, lambda { order("campaigns.created_at DESC") }

  #############
  # Searching #
  #############

  after_save :load_into_soulmate, unless: ->(){ Rails.env.test? }
  before_destroy :remove_from_soulmate

  def remove_from_soulmate
    Soulmate::Loader.new("campaign").remove "id" => id
  end

  def load_into_soulmate
    loader = Soulmate::Loader.new("campaign")
    loader.add({
      "id" => id,
      "term" => name,
      "class" => self.class.name,
      "url" => Rails.application.routes.url_helpers.campaign_path(self)})
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('campaign').matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "value" => match["term"],
        "class" => match["class"],
        "avatar_url" => "",
        "url" => match["url"]
      }
    end
  end

  #############

  def amount
    pledges.collect do |pledge|
      pledge.amount.to_i
    end.inject(:+).to_i
  end
  
end
