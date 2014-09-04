class Performer < User

  ################
  # Associations #
  ################

  has_many :performances
  has_many :campaigns, through: :performances

  ##########
  # Avatar #
  ##########

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  #############
  # Searching #
  #############

  after_save :load_into_soulmate, unless: ->(){ Rails.env.test? }

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
        "image" => match["image"],
        "url" => match["url"]
      }
    end
  end

end