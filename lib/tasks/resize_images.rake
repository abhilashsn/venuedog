namespace :reprocess_images do

  desc "Reprocess Event Images"
  task :event_images => :environment do
    puts "Reprocessing Event images."
    @events = Event.all
    @events.each do |e|
      if e.image?
        puts "Reprocessing '" + e.name + "' images."
        e.image.reprocess!
      end
    end
  end


  desc "Reprocess Venue Images"
  task :venue_images => :environment do
    puts "Reprocessing Venue images."
    @venues = Venue.all
    @venues.each do |v|
      if v.is_venue? and v.image?
        puts "Reprocessing '" + v.name + "' images."
        v.image.reprocess!
      end
    end
  end


end
