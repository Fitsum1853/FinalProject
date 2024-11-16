class RemoveEmailFromCoaches < ActiveRecord::Migration[7.1]
  def change
    remove_column :coaches, :email, :string
  end
end
