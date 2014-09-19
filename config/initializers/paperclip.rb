if Rails.env.production? || Rails.env.development?
  Paperclip::Attachment.default_options.merge!(
    :storage => :s3,
    :path => "/:attachment/:id/:style/:filename",
    :default_url => "/missing_:style.png",
    :s3_permissions => :public_read,
    :s3_credentials => {
      :bucket => SS_CONFIG.amazon_bucket,
      :access_key_id => SS_CONFIG.amazon_access_key_id,
      :secret_access_key => SS_CONFIG.amazon_secret_access_key
    }
  )
else
  Paperclip::Attachment.default_options.merge!(
    :url => "/system/:attachment/:id/:style/:filename",
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :default_url => "/missing_:style.png",
  )
end