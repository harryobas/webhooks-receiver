class CreatePullRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :pull_requests do |t|
      t.integer :request_id
      t.integer :number
      t.string :state
      t.string :title
      t.references :user, foreign_key: true
      t.string :body
      t.datetime :closed_at
      t.string :merge_commit_sha
      t.references :head, foreign_key: true
      t.integer :commits

      t.timestamps
    end
  end
end
