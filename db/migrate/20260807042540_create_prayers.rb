class CreatePrayers < ActiveRecord::Migration[8.1]
  def change
    create_table :prayers do |t|
      t.string :prayer
      t.text :specification

      t.timestamps
    end
  end
end
