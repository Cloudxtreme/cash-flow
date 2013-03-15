if Rails.env.development?

  # AWS S3
  ENV['STRIPE_API_KEY']         = ENV['STRIPE_TEST_API_KEY']
  ENV['STRIPE_PUBLIC_KEY']      = ENV["STRIPE_TEST_PUBLIC_KEY"]

  ENV['DOMAIN']                 = ENV['DEVELOPMENT_DOMAIN']

elsif Rails.env.production?

  # AWS S3
  ENV['STRIPE_API_KEY']         = ENV["STRIPE_LIVE_API_KEY"]
  ENV['STRIPE_PUBLIC_KEY']      = ENV["STRIPE_LIVE_PUBLIC_KEY"]

  ENV['DOMAIN']                 = ENV['PRODUCTION_DOMAIN']

end