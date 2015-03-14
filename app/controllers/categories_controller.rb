class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @city = City.find( params[:city_id] )
    @category = Category.all
    add_breadcrumb "Categories", categories_path( @city, @category )
  end


  def show
    @city = City.find( params[:city_id] )
    @category = Category.find(params[:id])
    @category_events = @category.self_and_descendants.collect{ |x| x.events.upcoming.approved.where(:city_id => @city.id) }.flatten.uniq.sort_by {|s| s.start_time}
    @category_events = Kaminari.paginate_array(@category_events).page(params[:page]).per(10)
    @featured_event = @category.self_and_descendants.map{|x| x.events.upcoming.approved.where(:city_id => @city.id) }.flatten.uniq.sort_by {|s| s.start_time}.first

    add_breadcrumb "Categories", categories_path
    if !@category.root?
      add_breadcrumb @category.root.name, category_path(@city, @category.root)
    end
    add_breadcrumb @category.name, category_path(@city, @category)
  end

end
