#Venuedog API

module Venuedog
  class API < Grape::API
    rescue_from :all
    prefix "woof"
    error_format :json

    resource "categories" do
      get '/show/all' do
        Category.select("id, name, lft, rgt, parent_id").all
      end

      get '/show/:id' do
        Category.select("id, name, lft, rgt, parent_id").find(params[:id])
      end
    end

    resource "events" do
      get '/show_by_date',  { :params => [ "start_date", "end_date" ], :optional_params => [ "categories" ] } do
        categories = nil
        if params.has_key?("categories")
          categories = params[:categories].split(',').map {|c| Category.find(c.to_i)}
        end

        start_date = Date.parse(params[:start_date]).strftime("%Y-%m-%d")
        end_date = Date.parse(params[:end_date]).strftime("%Y-%m-%d")
        events = {}

        if categories != nil
          cat = Event.where("start_time >= ? AND start_time <= ? AND city_id = ?", start_date.to_datetime, end_date.to_datetime, 1).find_all{|e| !(e.categories & categories).empty?}
          cat.each do |c|
            date_key = c.start_time.strftime("%Y-%m-%d")
            c["venue_name"] = c.venue.name if !c.venue.blank?
            c["venue_zip"] = c.venue.zip if !c.venue.blank?
            if events.has_key?(date_key)
              events[date_key] = events[date_key] << c
            else
              events[date_key] = [c]
            end

          end
          Hash[events.sort]
        else
          cat = Event.where("start_time >= ? AND start_time <= ? AND city_id = ?", start_date.to_datetime, end_date.to_datetime, 1)
          cat.each do |c|
            date_key = c.start_time.strftime("%Y-%m-%d")
            c["venue_name"] = c.venue.name if !c.venue.blank?
            c["venue_zip"] = c.venue.zip if !c.venue.blank?
            if events.has_key?(date_key)
              events[date_key] = events[date_key] << c
            else
              events[date_key] = [c]
            end
          end
          Hash[events.sort]

        end
      end



      # Popular events for widgets
      get '/popular' do
        Event.popular_homepage_rome
      end

    end




  end
end
