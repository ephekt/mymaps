class AddMarkerIdentifierToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :marker_identifier, :string
  end

  def self.down
  end
end
