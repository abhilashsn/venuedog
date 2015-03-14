
namespace :bootstrap do

#  desc "Create the default role"
#  task :default_role => :environment do
#    Role.create(:name => ADMINISTRATIVE_ROLE)
#  end

#   desc "Add the default user"
#   task :default_user => :environment do
#     puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#     puts "!!PLEASE DO NOT FORGET TO CHANGE THE ADMIN PASSWORD!!"
#     puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#     u = User.new(:email => "admin@saidigital.co", :password => '111111', :password_confirmation => '111111')
#     u.roles << Role.where('name = ?', ADMINISTRATIVE_ROLE)
#     u.save
#   end

   desc "Create the Categories"
   task :default_categories => :environment do
     categories = {
     :arts_and_culture => ['Art', 'Theatre', 'Cinema'],
     :music => ['Bluegrass', 'Country', 'Rock and Roll', 'Alternative', 'Pop', 'Hip Hop/Rap', 'Christian', 'Jazz', 'Other Music Genre'],
     :nightlife => [],
     :education => ['Community Education', 'K-12', 'College/University'],
     :outdoor => [],
     :sports => ['Baseball', 'Basketball', 'Golf', 'Football', 'Softball', 'Other Sports'],
     :community => ['Yard/Garage Sale', 'Religious Event', 'Fundraiser', 'Car Show', 'Hobbyist'],
     :kids_and_family => []
     }

     categories.each_pair  do |k,v|
       category = Category.create!(:name => k.to_s.titleize)
       v.each do |i|
         subcategory = Category.create!(:name => i.titleize)
         subcategory.move_to_child_of(category)
       end
     end
   end


  desc "Create the default pages"
  task :default_pages => :environment do
    Page.create(:title => "About", :content=>"Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus." ,:url => "About")
    Page.create(:title => "Contact Us", :content=>"Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus." ,:url => "contect-us")
  end





   desc "Run all bootstrapping tasks"
   #task :all => [:default_role,:default_user, :default_facilities, :default_zip_codes]
   task :all => [:default_role,:default_user, :default_categories, :default_pages]

end
