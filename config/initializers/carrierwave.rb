CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  # else
  #   # config.cache_dir = Rails.root.join 'tmp', 'uploads'
  #   config.fog_credentials = {
  #     provider:               'AWS',
  #     aws_access_key_id:      ENV['AWS_KEY']
  #     aws_secret_access_key:  ENV['AWS_SECRET_KEY']
  #   }
  #   config.fog_directory  = ENV['AWS_DIRECTORY']
  #   config.storage = :fog
  #   # config.enable_processing = false if Rails.env.test? or Rails.env.cucumber?
  #   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end
