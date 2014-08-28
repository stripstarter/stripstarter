class User < ActiveRecord::Base

  acts_as_authentic

  include StripstarterErrors

  ################
  # Associations #
  ################

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

  def pledges
    raise UserMismatchError, "User is not pledger" if !pledger?
    super
  end

  def performances
    raise UserMismatchError, "User is not performer" if !performer?
    super
  end

  def campaigns
    case
    when pledger?
      pledges.map(&:campaign)
    when performer?
      performances.map(&:campaign)
    else
      super
    end
  end
end
