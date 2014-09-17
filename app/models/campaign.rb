class Campaign < ActiveRecord::Base

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

  scope :newest, ->() { order("campaigns.created_at DESC") }
  scope :active, ->() { where(status: "active") }
  scope :inactive, ->() { where(status: "inactive") }
  scope :completed, ->() { where(status: "completed") }
  scope :canceled, ->() { where(status: "active") }

  ##########
  # States #
  ##########

  state_machine :status, initial: :inactive do

    state :active, value: "active"
    state :inactive, value: "inactive"
    state :completed, value: "completed"
    state :canceled, value: "canceled"

    event :activate do
      transition inactive: :active
    end
    event :deactive do
      transition active: :inactive
    end
    event :complete do
      transition active: :completed
    end
    event :cancel do
      transition [:active, :inactive, :completed] => :canceled
    end
    event :renew do
      transition canceled: :active
    end
  end

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
      "klass" => self.class.name,
      "url" => Rails.application.routes.url_helpers.campaign_path(self)})
  end

  def self.search(term)
    matches = Soulmate::Matcher.new("campaign").matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "value" => match["term"],
        "klass" => match["klass"],
        "avatar_url" => "",
        "url" => match["url"]
      }
    end
  end

  def amount
    pledges.collect do |pledge|
      pledge.amount.to_i
    end.inject(:+).to_i
  end
  
end
