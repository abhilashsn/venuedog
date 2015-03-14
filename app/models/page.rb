# == Schema Information
#
# Table name: pages
#
#  id               :integer(4)      not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  title            :string(255)
#  content          :text
#  meta_keywords    :string(255)
#  meta_description :string(255)
#  url              :string(255)
#

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
end
