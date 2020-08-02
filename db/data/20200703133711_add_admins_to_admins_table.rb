class AddAdminsToAdminsTable < ActiveRecord::Migration[6.0]
  def up
    Admin.create(email: 'kozyrevkirill7@gmail.com', password: Settings.admins.password)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
