class CreatePushes < ActiveRecord::Migration[5.2]
  def change
    create_table :pushes do |t|
      t.references :commits, foreign_key: true
      t.references :repository, foreign_key: true
      t.datetime :pushed_at
      t.references :pusher, foreign_key: true

      t.timestamps
    end
  end
end
