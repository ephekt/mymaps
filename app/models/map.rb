class Map < ActiveRecord::Base
  validates_presence_of :name, :description
  
  has_many :points, :dependent => :delete_all
end
