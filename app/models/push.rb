class Push < ApplicationRecord
  has_many :commits, as: :commitable
  belongs_to :repository
  belongs_to :pusher
end
