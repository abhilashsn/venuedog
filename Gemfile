  source 'http://rubygems.org'
ruby "1.9.2"

group :development do
  gem 'heroku_san'
  gem 'better_errors'
  gem 'binding_of_caller'

end

group :test, :development do

  #To get annotate to run you need to run:
  #  bundle exec annotate --exclude tests,fixtures
  #after you install it.
  #You won't need to run it unless you have new models.
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'

  gem "rspec-rails", "~> 2.6"
  gem "factory_girl_rails"
  gem "capybara"
  gem "sqlite3"
  gem "taps"
end

#I think this should not change, but try it and see. Something with engine yard not playing nice.
#gem 'bundler', '~> 1.0.18' # I marked this out 2013.07.11, couldn't get it to run
gem 'rails', '3.1.10'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2', '~> 0.3.7'
gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem 'devise'
gem 'cancan'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'awesome_nested_set'
gem 'execjs'
gem 'therubyracer'
gem "breadcrumbs_on_rails"
gem "omniauth-facebook"
gem "ckeditor"
gem "facebooker2"
gem "ri_cal"
gem 'fancybox-rails'
gem 'kaminari'
gem 'fog'
gem "tlsmail"
gem "delayed_job_active_record"
gem "daemons"
gem "htmlentities"
gem "grape"
gem "rack-contrib"
gem "geocoder"
gem 'passenger', '>= 4.0.16'

gem "friendly_id", "~> 4.0.9"
gem 'exception_notification', :group => [:staging, :production]
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "american_date"
