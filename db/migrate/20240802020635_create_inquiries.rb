class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.integer :genre_id
      t.string :company
      t.string :name
      t.string :name_kana
      t.string :email
      t.string :telephone_number
      t.text :body
      t.boolean :is_deleted, default: false
      t.timestamps
    end
  end
end
