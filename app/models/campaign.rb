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

  #############
  # Searching #
  #############

  after_save :load_into_soulmate

  def load_into_soulmate
    loader = Soulmate::Loader.new("campaign")
    loader.add("term" => name, "id" => id)
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('campaign').matches_for_term(term)
    matches.collect {|match| {"id" => match["id"], "label" => match["term"], "value" => match["term"] } }
  end

  #############

  def amount
    pledges.collect do |pledge|
      pledge.amount.to_i
    end.inject(:+)
  end
  
end
