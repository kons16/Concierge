CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: "<%= ENV['IAM_ACCESS_KEY'] %>",
      aws_secret_access_key: "<%= ENV['IAM_SECRET_KEY'] %>",
      region: 'ap-northeast-1'
  }

  config.fog_directory  = 'chatapp-myicon'
  config.cache_storage = :fog
end
