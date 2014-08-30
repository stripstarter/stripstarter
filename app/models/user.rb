class User < ActiveRecord::Base

  acts_as_authentic

  ###############
  # Travis hack #
  ###############

  if Rails.env.test?
    attr_accessor :password, :password_confirmation
  end

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :on => :create
  validates :password, :confirmation => true,
                       :length => {:within => 6..40},
                       :allow_blank => true,
                       :on => :update

  def name
    [first_name, last_name].join(" ")
  end

end