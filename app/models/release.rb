class Release < ApplicationRecord
  has_one :author, as: :authorable
  has_many :commits, as: :commitable
  has_one :repository, as: :repositable
end
