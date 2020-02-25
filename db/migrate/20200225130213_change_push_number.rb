class ChangePushNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :pushers, :pusher_number, :pusher_id
  end
end
