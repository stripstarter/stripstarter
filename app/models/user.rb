class User < ActiveRecord::Base

  acts_as_authentic

  ###############
  # Travis hack #
  ###############

  attr_accessor :password, :password_confirmation

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :on => :create
  validates :password, :confirmation => true,
                       :length => {:within => 6..40},
                       :allow_blank => true,
                       :on => :update

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

  ####################
  # Associations, II #
  ####################

  def pledges
    raise Stripstarter::Error::UserMismatch, "User is not pledger" if !pledger?
    super
  end

  def performances
    raise Stripstarter::Error::UserMismatch, "User is not performer" if !performer?
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
