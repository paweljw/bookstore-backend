class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.belongs_to :author, foreign_key: true
      t.string :title
      t.monetize :price
      t.timestamps
    end
  end
end
