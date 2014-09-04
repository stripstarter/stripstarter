Paperclip::Attachment.default_options.merge!(
  :storage => :s3,
  :path => "/avatar/:id/:style/:filename",
  :s3_permissions => :public_read,
  :s3_credentials => {
    :bucket => SS_CONFIG.amazon_bucket,
    :access_key_id => SS_CONFIG.amazon_access_key_id,
    :secret_access_key => SS_CONFIG.amazon_secret_access_key
  }
)