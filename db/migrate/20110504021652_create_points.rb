class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer :map_id
      t.float :lat, :null => false, :limit => 12
      t.float :lng, :null => false, :limit => 12
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
