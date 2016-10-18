class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :excerpt
      t.string :url
      t.string :image
      t.references :source, foreign_key: true
      t.references :newsletter, foreign_key: true

      t.timestamps
    end
  end
end
