CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_privider = "fog"
    config.fog_credentials {
      provider:             'AWS',
      aws_acess_key_id:      ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION'],
    }
    config.fog_directory   = ENV['AWS_BUCKET_NAME']

  else
    config.storage :file
  end
end
