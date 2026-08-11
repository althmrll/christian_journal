class AddPasswordToAccess < ActiveRecord::Migration[8.1]
  def change
    add_column :accesses, :password, :string
  end
end
