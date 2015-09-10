class ShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, unique: true, null: false
      t.string :short_url, unique: true, null: false
      t.integer :submitted_id, null: false

      t.timestamps
    end
  end
end
