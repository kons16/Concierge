CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: '',
      aws_secret_access_key: '',
      region: 'ap-northeast-1'
  }

  config.fog_directory  = 'rails-photo-123'
  config.cache_storage = :fog
end
