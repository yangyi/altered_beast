class Board < ActiveRecord::Base
  has_many :forums
  belongs_to :site
  formats_attributes :description
end
