class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.integer :auth_id
      t.string :name
      t.string :email
      t.references :authorable, polymorphic: true

      t.timestamps
    end
  end
end
