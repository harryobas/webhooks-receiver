class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pushers, :pusher_id, :pusher_number
  end
end
