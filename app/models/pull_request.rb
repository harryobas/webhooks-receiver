class PullRequest < ApplicationRecord
  belongs_to :user
  belongs_to :head
end
