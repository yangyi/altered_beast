class AddBoardsPosition < ActiveRecord::Migration
  def self.up
    add_column :boards, :position, :integer, :default => 0
  end

  def self.down
    remove_column :boards, :position
  end
end
