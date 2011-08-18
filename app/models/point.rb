class Point < ActiveRecord::Base
  validates_presence_of :lat, :lng, :marker_identifier
  
  scope :for_editing, select("description, lat, lng")
end
