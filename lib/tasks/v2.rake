namespace :v2 do

  desc "Create friendly ids for existing records"
  task :generate_friendly_ids => :environment do
    puts "Creating friendly ids for Events."
    Event.find_each(&:save)

    puts "Creating friendly ids for Venues."
    Venue.find_each(&:save)

    puts "Creating friendly ids for Cities."
    City.find_each(&:save)

    puts "Creating friendly ids for Categories."
    Category.find_each(&:save)

    puts "Creating friendly ids for Pages."
    Page.find_each(&:save)
  end

end
