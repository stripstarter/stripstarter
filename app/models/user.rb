class User < ActiveRecord::Base

  acts_as_authentic

  ##########
  # Avatar #
  ##########

  has_attached_file :avatar,
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    # url: "/system/avatar/:id/:style/:filename",
                    path: ":rails_root/public/system/avatar/:id/:style/:filename"

  attr_accessor :avatar_file_name,
                :avatar_content_type,
                :avatar_file_size

  validates_attachment  :avatar,
                        :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                        :size => { :in => 0..2.megabytes }

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