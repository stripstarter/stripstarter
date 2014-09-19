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
                    }

  validates_attachment  :image,
                        :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                        :size => { :in => 0..2.megabytes }


end
