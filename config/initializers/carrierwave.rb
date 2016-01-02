CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAJRCTY3ULEUUYIY7A',
    aws_secret_access_key: '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'
  }
  config.fog_directory = "print-from-anywhere"
end