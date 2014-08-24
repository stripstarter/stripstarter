class User < ActiveRecord::Base
  acts_as_authentic

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
