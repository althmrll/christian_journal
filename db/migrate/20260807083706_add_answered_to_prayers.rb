class AddAnsweredToPrayers < ActiveRecord::Migration[8.1]
  def change
    add_column :prayers, :answered, :boolean
  end
end
