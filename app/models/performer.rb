class Performer < User

  ################
  # Associations #
  ################

  has_many :performances
  has_many :campaigns, through: :performances

  #############
  # Searching #
  #############

  after_save :load_into_soulmate

  def load_into_soulmate
    loader = Soulmate::Loader.new("pledger")
    loader.add({
      "term" => name,
      "id" => id,
      "image" => "/test_avatar.png",
      "url" => Rails.application.routes.url_helpers.performer_path(self)})
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('pledger').matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "label" => "performer",
        "value" => match["term"],
        "image" => match["image"]
      }
    end
  end

end