class User < ActiveRecord::Base
  acts_as_authentic

  has_many :pledges
  has_many :campaigns, through: :pledges

  has_many :performances
  has_many :campaigns, through: :performances

  #########
  # Roles #
  #########

  scope :pledger,   ->{ where("role = 'pledger'")}
  scope :admin,     ->{ where("role = 'admin'")}
  scope :performer, ->{ where("role = 'performer'")}

  def pledger?
    role == "pledger"
  end

  def admin?
    role == "admin"
  end

  def performer?
    role == "performer"
  end

end
