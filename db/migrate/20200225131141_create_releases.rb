class CreateReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :releases do |t|
      t.string :action
      t.datetime :released_at
      t.integer :release_id
      t.string :tag_name
      t.references :author, foreign_key: true
      t.references :commits, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
