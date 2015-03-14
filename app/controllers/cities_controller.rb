class CitiesController < ApplicationController
  load_and_authorize_resource

  # Homepage for each city
  def show
    @city = City.find(params[:city_id])
    @categories = Category.roots[0..7]
    @slides = @city.frontpage_sliders.order('weight DESC').where('CURDATE() BETWEEN start_date AND end_date')
    @featured_venue = @city.venues.featured.first

    if params[:set] == "current-city"
      if !current_user.blank?
        @usr = current_user
        @usr.city = @city
        @usr.save
      end
      
      cookies[:current_city] = { value: @city.id, expires: 10.years.from_now, domain: :all }
    end
  end

end
