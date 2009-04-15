class AddBoardsSiteId < ActiveRecord::Migration
  def self.up
    add_column :boards, :site_id, :integer
  end

  def self.down
    remove_column :boards, :site_id
  end
end
