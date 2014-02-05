class CreateLinks < ActiveRecord::Migration
  def up
    create_table :links do |t|
      t.string :url
      t.string :shortUrl
      t.integer :count, :default => 0
      t.timestamps
    end
  end

  def down
    drop_table :links
  end
end
