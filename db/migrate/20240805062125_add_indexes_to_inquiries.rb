class AddIndexesToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_index :inquiries, :company
    add_index :inquiries, :name
  end
end
