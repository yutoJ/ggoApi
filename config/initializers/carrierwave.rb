CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: ENV["AWS_REGION_CODE"],
    path_style: true,
  }

  config.fog_public = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  case Rails.env
  when 'production'
    if ENV["INFRA_SERVICE_NAME"] == "aws"
      config.fog_directory = ENV["AWS_S3_PD"]
      config.asset_host = ENV["AWS_S3_PD_URL"]
    elsif ENV["INFRA_SERVICE_NAME"] == "heroku"
      config.fog_directory = ENV["AWS_S3_ST"]
      config.asset_host = ENV["AWS_S3_ST_URL"]
    end
  when 'development'
    if ENV["AWS_S3_DEV"] && ENV["AWS_S3_DEV_URL"]
      config.fog_directory = ENV["AWS_S3_DEV"]
      config.asset_host = ENV["AWS_S3_DEV_URL"]
    else
      config.fog_directory = "dummy"
      config.asset_host = "dummy"
    end
  end
end
