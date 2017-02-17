class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true
      t.integer :user_id
      t.integer :post_id
      t.text :content

      t.timestamps
    end
  end
end
