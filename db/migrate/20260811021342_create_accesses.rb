class CreateAccesses < ActiveRecord::Migration[8.1]
  def change
    create_table :site_accesses do |t|
      t.string :password

      t.timestamps
    end
  end
end
