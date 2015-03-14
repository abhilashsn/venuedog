class ApplicationController < ActionController::Base

  before_filter :login_redirect
  before_filter :set_current_city

  protect_from_forgery

  add_breadcrumb "Home", :root_path
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end


  



  # Error page action
  def render_404
    render :template => 'error_pages/404', :layout => true, :status => :not_found
  end



  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end




  # Set current_city based on user record and cookie.
  # If no city has been recorded, load choose city page.
  def set_current_city

    current_city = ''

    if request.fullpath == '/'

      if user_signed_in?      ########### SIGNED IN - Cases: City, No City (with cookie), No City (no cookie)

        if current_user.city.blank?
          if !cookies[:current_city].blank?
            current_city = City.where( :id => cookies[:current_city] ).where(:approved => true).first
            if !current_city.blank?
              cookies[:current_city] = { value: current_city.id, expires: 10.years.from_now, domain: :all } if !current_city.blank?
              redirect_to city_path( current_city ) if !current_city.blank?
            end
          end
        elsif !current_user.city.blank?
          current_city = City.where( :id => current_user.city.id ).where(:approved => true).first
          cookies[:current_city] = { value: current_city.id, expires: 10.years.from_now, domain: :all } if !current_city.blank?
          redirect_to city_path( current_city ) if !current_city.blank?
        end

      elsif !user_signed_in?  ########### NOT SIGNED IN - Cases - Cookie, No Cookie

        if !cookies[:current_city].blank?
          current_city = City.where( :id => cookies[:current_city] ).where(:approved => true).first
          redirect_to city_path( current_city )
        end

      end

   
    elsif params[:dog] == "sit" and !params[:city_id].blank?

      current_city = City.find(params[:city_id])
      cookies[:current_city] = { value: current_city.id, expires: 10.years.from_now, domain: :all }
      if !current_user.blank?
        user = current_user
        user.city = current_city
        user.save
      end

    end

  end




  # Setup cookie containing previous URL when user goes to sign in
  # Redirect user to prev page once they sign in and are directed home
  # by Facebook
  def login_redirect
    if request.fullpath == '/users/sign_in' or request.fullpath == '/users/sign_up'
      cookies[:previous_page] = request.referrer
    end
    if request.fullpath == '/#_=_'
      if !cookies[:previous_page].blank? and cookies[:previous_page].include? "venuedog.com"
        redirect_to cookies[:previous_page]
      end
    end
  end



end
