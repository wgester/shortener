class Links < ActiveRecord::Migration
  def up
    create_table :Links do |t|
        t.string :url
        t.string :shortUrl
      end
  end

  def down
    drop_table :shortLinks
  end
end
