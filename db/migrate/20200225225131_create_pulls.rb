class CreatePulls < ActiveRecord::Migration[5.2]
  def change
    create_table :pulls do |t|
      t.string :action
      t.integer :number
      t.references :pull_request, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
