# config.paperclip_defaults = {
#   :storage => :s3,
#   :s3_credentials => {
#     :bucket => ENV['S3_BUCKET_NAME'],
#     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
#   }
# }

Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:bucket] = 'ssmedia1'
Paperclip::Attachment.default_options[:access_key_id] = SS_CONFIG.amazon_access_key_id
Paperclip::Attachment.default_options[:secret_access_key] = SS_CONFIG.amazon_secret_access_key