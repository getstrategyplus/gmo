class CreateNewsletters < ActiveRecord::Migration[5.0]
  def change
    create_table :newsletters do |t|
      t.string :title
      t.text :excerpt
      t.string :address_url

      t.timestamps
    end
  end
end
