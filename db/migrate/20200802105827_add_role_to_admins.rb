class AddRoleToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :role, :string, null: false, default: 'superadmin'
  end
end
