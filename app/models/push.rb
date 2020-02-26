class Push < ApplicationRecord
  has_many :commits, as: :commitable
  has_one :repository, as: :repositable
  belongs_to :pusher
end
