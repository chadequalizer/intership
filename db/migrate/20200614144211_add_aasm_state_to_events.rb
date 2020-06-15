class AddAasmStateToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :state, :string, null: false, default: 'pending'
  end
end
