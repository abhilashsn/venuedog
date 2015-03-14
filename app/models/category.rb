# == Schema Information
#
# Table name: categories
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  parent_id          :integer(4)
#  lft                :integer(4)
#  rgt                :integer(4)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_nested_set

  # Associations
  has_and_belongs_to_many :events
  has_and_belongs_to_many :ads

  has_attached_file :image, :styles => { :thumb70x70 => "70x70^" , :thumb100x90 => "100x90^", :medium => "240x175^", :large =>"320x280^" },
              :processor => "mini_magick",
              :convert_options => {
                :thumb70x70 => "-gravity center -extent 70x70",
                :thumb100x90 => "-gravity center -extent 100x90",
                :medium => "-gravity center -extent 240x175",
                :large => "-gravity center -extent 320x280"
              }

  # Validations
  validates_presence_of :name
  #validates_attachment_presence :image




  # Search
  def self.search(search)
    if search
      fields = ['name']
      fields.collect! {|x| x + " LIKE '%#{search}%'"}

      return self.where(fields.join(' OR '))
    end
  end



end
