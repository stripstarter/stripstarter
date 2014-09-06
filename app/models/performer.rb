class Performer < User

  ################
  # Associations #
  ################

  has_many :performances
  has_many :campaigns, through: :performances

  #############
  # Searching #
  #############

  after_save :load_into_soulmate, unless: ->(){ Rails.env.test? }
  before_destroy :remove_from_soulmate

  def remove_from_soulmate
    Soulmate::Loader.new("performer").remove "id" => id
  end
  
  def load_into_soulmate
    loader = Soulmate::Loader.new("performer")
    loader.add({
      "id" => id,
      "term" => name,
      "class" => self.class.name,
      "avatar_url" => avatar.url(:thumb),
      "url" => Rails.application.routes.url_helpers.performer_path(self)})
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('performer').matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "value" => match["term"],
        "class" => match["class"],
        "avatar_url" => match["avatar_url"],
        "url" => match["url"]
      }
    end
  end

end