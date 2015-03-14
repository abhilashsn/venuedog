# == Schema Information
#
# Table name: attachments
#
#  id                    :integer(4)      not null, primary key
#  venue_id              :integer(4)
#  attachment_file_name  :string(255)
#  attachment_file_type  :string(255)
#  attachment_file_size  :integer(4)
#  attachment_updated_at :datetime
#  created_at            :datetime
#  updated_at            :datetime
#  name                  :string(255)
#

class Attachment < ActiveRecord::Base
  belongs_to :venue
  has_attached_file :attachment, :styles => { :venue_show_thumbnail => "60x50^", :venue_show =>"320x280^" },
              :processor => "mini_magick",
              :convert_options => {
                :venue_show => "-gravity center -extent 320x280",
                :venue_show_thumbnail => "-gravity center -extent 60x50",
              }
end
