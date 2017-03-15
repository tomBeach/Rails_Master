# ======= db/migrate/20170221250000_create_photos.rb =======
class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :caption
      t.string :content_type
      t.datetime :date_taken

      t.timestamps
    end
  end
end
