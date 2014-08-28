class Performer < User

  ################
  # Associations #
  ################

  has_many :performances
  has_many :campaigns, through: :performances

end