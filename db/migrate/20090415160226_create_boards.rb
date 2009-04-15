class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :title
      t.text :description
      t.text :description_html
      t.timestamps
    end
    add_column :forums, :board_id, :integer
  end

  def self.down
    remove_column :forums, :board_id
    drop_table :boards
  end
end
