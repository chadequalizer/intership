class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.text :description
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.string :organizer_email
      t.string :organizer_telegram
      t.string :link

      t.timestamps
    end
  end
end
