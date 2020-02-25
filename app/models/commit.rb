class Commit < ApplicationRecord
  has_one :author, as: :authorable
  belongs_to :commitable, polymorphic: true
end
