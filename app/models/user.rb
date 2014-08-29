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

end