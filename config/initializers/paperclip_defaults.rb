if Rails.env.production?

  Paperclip::Attachment.default_options.update({
    :path => ":attachment/:id/:style/:filename",
    :storage => :fog,
    :fog_credentials => {
      :provider           => 'Rackspace',
      :rackspace_username => 'steeleagency',
      :rackspace_api_key  => '24e9074a4d98072a852c1c8a5c4b7141',
      :persistent => false
    },
    :fog_directory => 'venuedog_production',
    :fog_public => true,
    :fog_host => 'http://c953364.r64.cf2.rackcdn.com'
  })

elsif Rails.env.staging?

  Paperclip::Attachment.default_options.update({
    :path => ":attachment/:id/:style/:filename",
    :storage => :fog,
    :fog_credentials => {
      :provider           => 'Rackspace',
      :rackspace_username => 'steeleagency',
      :rackspace_api_key  => '24e9074a4d98072a852c1c8a5c4b7141',
      :persistent => false
    },
    :fog_directory => 'venuedog_staging',
    :fog_public => true,
    :fog_host => 'http://528a75e598b01bc49667-0033ff967a13b4bcdab18e7f0eebe502.r94.cf2.rackcdn.com'
  })

end
