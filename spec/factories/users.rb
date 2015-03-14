# Getting error:
#   /home/rroyal/.rvm/gems/ruby-1.9.2-p320@venuedog/gems/factory_girl-2.6.1/lib/factory_girl/deprecated.rb:7:in `method_missing': undefined method `sequence' for Factory:Module (NoMethodError)
#  from /home/rroyal/projects/venuedog/spec/factories/users.rb:1:in `<top (required)>'
#
#Factory.sequence :email do |n|
#    "sean+#{n}@saidigital.co"
#end
#
#
#Factory.define :role do |r|
#    r.name 'VenuedogUser'
#end
#
#Factory.define(:user) do |f|
#  f.name "Sean Brewer"
#  f.email { |e| e.email = Factory.next(:email) }
#  f.password "1234567"
#  f.password_confirmation "1234567"
#  f.roles [Factory(:role)]
#end
