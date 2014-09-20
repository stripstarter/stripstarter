class Photo < ActiveRecord::Base

  belongs_to :performance
  delegate :performer, to: :performance
  delegate :campaign, to: :performance

  validates_presence_of :performance

  ##########
  # Image #
  ##########

  has_attached_file :image,
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    url: "/:attachment/:id/:style/:filename",
                    path: ":attachment/:id/:style/:filename",
                    default_url: "/missing_:style.png",
                    :storage => :fog,
                    :fog_credentials => {
                      :provider => "Local",
                      :local_root => "#{Rails.root}"
                    },
                    :fog_directory => "",
                    :fog_host => "#{Rails.root}"

  validates_attachment  :image,
                        :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                        :size => { :in => 0..2.megabytes }


end
