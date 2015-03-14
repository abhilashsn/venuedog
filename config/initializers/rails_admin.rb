#         ooooooooo.              o8o  oooo                 .o.             .o8                     o8o
#         `888   `Y88.            `"'  `888                .888.           "888                     `"'
#          888   .d88'  .oooo.   oooo   888   .oooo.o     .8"888.      .oooo888  ooo. .oo.  .oo.   oooo  ooo. .oo.
#          888ooo88P'  `P  )88b  `888   888  d88(  "8    .8' `888.    d88' `888  `888P"Y88bP"Y88b  `888  `888P"Y88b
#          888`88b.     .oP"888   888   888  `"Y88b.    .88ooo8888.   888   888   888   888   888   888   888   888
#          888  `88b.  d8(  888   888   888  o.  )88b  .8'     `888.  888   888   888   888   888   888   888   888
#         o888o  o888o `Y888""8o o888o o888o 8""888P' o88o     o8888o `Y8bod88P" o888o o888o o888o o888o o888o o888o

# RailsAdmin config file. Generated on September 27, 2011 17:01
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.current_user_method { current_user } # auto-generated
  config.authorize_with :cancan
  config.main_app_name { ['Venuedog', 'Admin'] } # auto-generated

  #  ==> Authentication (before_filter)
  # This is run inside the controller instance so you can setup any authentication you need to.
  # By default, the authentication will run via warden if available.
  # and will run on the default user scope.
  # If you use devise, this will authenticate the same as authenticate_user!
  # Example Devise admin
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     authenticate_admin!
  #   end
  # end
  # Example Custom Warden
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     warden.authenticate! :scope => :paranoid
  #   end
  # end

  #  ==> Authorization
  # Use cancan https://github.com/ryanb/cancan for authorization:
  # config.authorize_with :cancan

  # Or use simple custom authorization rule:
  # config.authorize_with do
  #   redirect_to root_path unless warden.user.is_admin?
  # end

  # Use a specific role for ActiveModel's :attr_acessible :attr_protected
  # Default is :default
  # current_user is accessible in the block if you want to make it user specific.
  # config.attr_accessible_role { :default }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 50

  #  ==> Included models
  # Add all excluded models here:
  config.excluded_models << [Role]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models << []

  # Application wide tried label methods for models' instances
  # config.label_methods << [:description] # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields :name, :other_name do
  #       # Configuration here will affect all fields named [:name, :other_name], in the list section, for all included models
  #     end
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field!
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Here goes your cross-section field configuration for ModelName.
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  #   show do
  #     # Here goes the fields configuration for the show view
  #   end
  #   export do
  #     # Here goes the fields configuration for the export view (CSV, yaml, XML)
  #   end
  #   edit do
  #     # Here goes the fields configuration for the edit view (for create and update view)
  #   end
  #   create do
  #     # Here goes the fields configuration for the create view, overriding edit section settings
  #   end
  #   update do
  #     # Here goes the fields configuration for the update view, overriding edit section settings
  #   end
  # end

# fields configuration is described in the Readme, if you have other question, ask us on the mailing-list!

#  ==> Your models configuration, to help you get started!


  # Events
  config.model Event do

    edit do
      group :basic do
        label "Basic"
        field :name do help '' end
        field :start_time
        field :end_time
        field :all_day
        field :approved do help 'Only approved events show on the frontend.' end
        field :venue do help 'Select or create venue for event.' end
        field :city do help 'Add official city for this event.' end
      end
      group :description do
        label "Description"
        field :description, :text do
          ckeditor true
          help ''
        end
        field :price do help 'Price description.' end
        field :image
      end
      group :categorize do
        label "Categorize"
        field :categories do
          associated_collection_cache_all true
        end
        field :labels
        field :user do help 'Optional. Primary system owner of event.' end
      end
      group :contact do
        label "Contact"
        field :event_host do help 'Name of host or supporting organization.' end
        field :event_contact do help 'Phone or email address of event contact.' end
        field :website do help 'Full URL.' end
        field :buy_tickets do help 'URL of ticket seller.' end
      end

      field :save_a_copy, :boolean

    end

  end


  # Pages
  config.model Page do
    edit do
      field :title do help '' end
      field :content do
        help ''
        ckeditor true
      end
      field :meta_keywords do help '' end
      field :meta_description do help '' end
      field :url do help '' end
    end
  end



  # Users
#  config.model User do
#    edit do
#      group :basic do
#        field :name do help '' end
#        field :email do help '' end
#        field :password do help '' end
#        field :password_confirmation do help '' end
#        field :roles
#        field :city do help '' end
#      end
#    end
#  end




  # City101, belongs to city
  config.model City101 do
    edit do
      field :city do help '' end
      field :description do
        help ''
        ckeditor true
      end
      field :links do
        help ''
        ckeditor true
      end
    end
  end




  # Venues
  config.model Venue do
    edit do

      group :basic do
        label "Basic"
        field :name do help '' end
        field :is_venue do
          label 'Is a Venue?'
          help 'Check this if this is an official venue and will have mulitple events.'
        end
        field :venue_categories do 
          help ''
          associated_collection_cache_all true
        end
        field :street_address do
          label "Street Address"
          help ''
        end
        field :city_name do help '' end
        field :state do help '' end
        field :zip do
          label "ZIP"
          help ''
        end
        field :city do help 'Official city for venue.' end
      end
      group :description do
        label "Description"
        field :description, :text do
          ckeditor true
          help ''
        end
        field :image do help 'Required primary image.' end
        field :attachments do help 'Attach secondary images and media.' end
        field :user do help "Public system user that owns venue." end
      end
      group :contact do
        label "Contact"
        field :phone do help '' end
        field :phone_alt do help '' end
        field :staff_name do help '' end
        field :staff_phone do help '' end
        field :staff_email do help '' end
        field :staff_address do help '' end
      end
      group :social do
        label "Connect"
        field :website do help '' end
        field :facebook do help '' end
        field :twitter do help '' end
        field :yelp do help '' end
        field :foursquare do help '' end
      end
      group :hours do
        label "Hours of Operation"
        field :monday do help '' end
        field :tuesday do help '' end
        field :wednesday do help '' end
        field :thursday do help '' end
        field :friday do help '' end
        field :saturday do help '' end
        field :sundays do help '' end
        field :hours_override do help 'Text in this field will be displayed in place of hour ranges above.' end
      end
      group :events do
        label "Associated Events"
        field :events do help '' end
      end
      field :venue_categories do
        associated_collection_cache_all true
      end
    end
  end



  # Categories for Events
  config.model Category do
    list do
      field :name
      field :parent
      field :children
    end

    show do
      field :name
      field :parent
      field :children
    end

    edit do
      field :name
      field :parent
      field :children
      field :image
    end
  end



  config.model Attachment do
    edit do
      field :name do help 'Helpful name.' end
      field :attachment do help '' end
      field :venue do help 'Associate attachment with a venue.' end
    end
  end



  # City Homepage sliders
  config.model FrontpageSlider do
    edit do
      field :name
      field :city
      field :image do
        label 'Image'
        help 'Image size 670x275px.'
      end
      field :start_date
      field :end_date
      field :url do
        label "URL"
        help 'Full URL when clicked.'
      end
      field :weight
    end
  end



  # Advertiser
  config.model Advertiser do
    edit do
      group :company_information do
        field :name do help '' end
        field :address_line_1 do help '' end
        field :address_line_2 do help '' end
        field :city do help '' end
        field :state do help '' end
        field :zip do help '' end
        field :phone do help '' end
        field :website do help '' end
      end
      group :contact_information do
        field :contact_name do help '' end
        field :contact_phone do help '' end
        field :contact_email do help '' end
      end
      group :ad_budget do
        field :budget_amount do help '' end
        field :period do help '' end
      end
      group :notes do
        field :notes do help '' end
      end
      group :ads do
        field :ads do help 'Current ads belonging to this Advertiser.' end
      end
    end
  end



  # Ad
  config.model Ad do
    edit do
      group :manage_ad do
        label "Manage Ad"
        field :name do help '' end
        field :advertiser do help 'Owner of the ad.' end
        field :destination do help 'URL to link ad to.' end
      end
      group :ad_size do
        label "Ad Size and Image"
        field :size do help '' end
        field :image do
          label 'Main Image'
          help 'Upload ad of correct size.'
        end
        field :page_wrap do
          label 'Page Wrap Image'
          help 'Optionally attach page-wrap ad to header ad.'
        end
        field :background_color do
          help 'Optional page background color for ad wrap (HEX).'
        end

      end
      group :locations do
        label "Ad Locations"
        field :on_homepage do
          label "On City Homepage?"
          help 'Rotate Ad on city homepage.'
        end
        field :on_global_homepage do
          label "On Global Homepage?"
          help 'Rotate Ad on choose city landing page sidebar and app page sidebar, (Sidebar Half or Sidebar Full).'
        end
        field :locations do
          help 'Special locations for ad rotation.'
        end
        field :categories do 
          help 'Rotate the ad on these categories' 
          associated_collection_cache_all true
        end
      end
      group :ad_times do
        label "Start and End Times"
        field :start do help 'Date to begin ad rotation.' end
        field :end do help 'Date to end ad rotation (inclusive).' end
      end
      group :other do
        field :cities do help 'Official City to serve this ad to.' end
        field :notes do help '' end
      end
    end
  end

  config.attr_accessible_role { :super_admin }

end

