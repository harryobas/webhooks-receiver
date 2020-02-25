class CreatePushers < ActiveRecord::Migration[5.2]
  def change
    create_table :pushers do |t|
      t.integer :pusher_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
