class CreateAccesses < ActiveRecord::Migration[8.1]
  def change
    create_table :accesses do |t|
      t.timestamps
    end
  end
end
