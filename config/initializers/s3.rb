CarrierWave.configure do |config|
  config.fog_credentials = {
      provider:                            'AWS',
      aws_access_key_id:          'AKIAITFIOKBMXRA4WDNA',
      aws_secret_access_key:   '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',
      region:                               'ap-southeast-1'
  }
  config.fog_directory  = 'fitbuds'
end





