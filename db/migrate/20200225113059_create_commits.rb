class CreateCommits < ActiveRecord::Migration[5.2]
  def change
    create_table :commits do |t|
      t.string :sha
      t.string :tickets
      t.datetime :date
      t.references :author, foreign_key: true
      t.references :commitable, polymorphic: true

      t.timestamps
    end
  end
end
