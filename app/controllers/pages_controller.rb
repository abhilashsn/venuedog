class PagesController < ApplicationController
  load_and_authorize_resource


  #For robots.txt
  def robots
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render :text => robots, :layout => false, :content_type => "text/plain"
  end


  # Root of app where user chooses and sets city.
  def homepage
    @states = City.approved.by_states
    render :layout => 'choose_city'
  end



  def show
    @page = Page.find(params[:page_id])
    add_breadcrumb @page.title,  "/" + @page.slug

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end




  # Contact Us Page
  def contact_us
    @page = Page.where(:title => "Contact Us").first
    add_breadcrumb @page.title, "/" + @page.url.downcase

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # Email Action for contact form : emails and redirects to contact page
  def email_contact
    contact = params[:contact]
    if contact.blank?
      redirect_to "/contact-us", :notice => 'Please fill out the form entirely.'
    else
      if contact[:name].blank? or contact[:email].blank? or contact[:subject].blank? or contact[:message].blank?
        redirect_to "/contact-us", :notice => 'Please fill out the form entirely.'
      else
        SystemEmail.contact_page_notification(contact).deliver
        redirect_to "/contact-us", :notice => 'Thank you for contacting us.'
      end
    end
  end





  def advertise_with_us
    @page = Page.where(:title => "Advertise with Us").first
    add_breadcrumb @page.title, "/" + @page.url.downcase

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end


  def advertise_with_us_contact_form
    AdvertiseWithUsMailer.advertise_contact_form(params[:name],params[:email],params[:tel],params[:company],params[:city]).deliver
    redirect_to "/advertise-with-us"
  end


  # FAQ & Privacy Policy pages
  def faqs
    @page = Page.where(:title => "FAQs").first
    add_breadcrumb @page.title, "/" + @page.url.downcase

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def privacy_policy
    @page = Page.where(:title => "Privacy Policy").first
    add_breadcrumb @page.title, "/" + @page.url.downcase

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

 
  def promote_events
    @page = Page.where(:title => "Promote Events on VenueDog").first
    add_breadcrumb @page.title, "/" + @page.url.downcase

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

end
