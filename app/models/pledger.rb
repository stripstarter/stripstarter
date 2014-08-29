class Pledger < User

  ################
  # Associations #
  ################

  has_many :pledges
  has_many :campaigns, through: :pledges

end