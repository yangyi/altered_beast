class Board < ActiveRecord::Base
  acts_as_list
  has_many :forums
  
  default_scope :order => 'position'
  
  belongs_to :site
  formats_attributes :description
end
