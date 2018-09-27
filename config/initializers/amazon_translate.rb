# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html
# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Translate/Client.html

Aws.config.update({
  region: Rails.application.credentials.aws[:region],
  credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id], Rails.application.credentials.aws[:secret_access_key])
})
