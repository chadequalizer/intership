class AddAdminsToAdmins < ActiveRecord::Migration[6.0]
  def up
    Admin.create(email: 'kozyrevkirill7@gmail.com', password: Settings.admins.password, role: 'superadmin')
    Admin.create(email: 'meenoos@yandex.ru', password: Settings.admins.password, role: 'moderator')
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
