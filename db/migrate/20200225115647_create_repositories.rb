class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.integer :repo_id
      t.string :name
      t.references :repositable, polymorphic: true

      t.timestamps
    end
  end
end
