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
    loader.add("term" => name, "id" => id, "url" => "/test_avatar.png")
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('pledger').matches_for_term(term)
    matches.collect {|match| {"id" => match["id"], "label" => "name", "value" => match["term"] } }
  end

end