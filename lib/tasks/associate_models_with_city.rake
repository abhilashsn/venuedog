namespace :associate_models_with_city do

  desc "Make User, Events, Frontpage Slider, Venue, and Ad belong to Rome City.where(:id=>1)"
  task :add_cities_main => :environment do

    rome = City.find(1)
    puts "Approving City: Rome"
    rome.approved = true
    rome.save


    puts "Making all Users belong to Rome."
    User.all.each do |user|
      user.city = rome
      user.save
    end

  
    puts "Making all Frontpage Sliders belong to Rome."
    FrontpageSlider.all.each do |slide|
      slide.city = rome
      slide.save
    end

    
    puts "Making all Events belong to Rome."
    Event.all.each do |e|
      e.city = rome
      e.save
    end

  
    puts "Making all Ads belong to Rome."
    Ad.all.each do |ad|
      if ad.cities.count < 1
        ad.cities << rome
        ad.save
      end
    end
    


    puts "Making all Venues belong to Rome."
    Venue.all.each do |v|
      v.city = rome
      v.save
    end


    puts "Making all Wifi hotspots belong to Rome."
    WifiHotspot.all.each do |h|
      h.city = rome
      h.save
    end


  end
end
