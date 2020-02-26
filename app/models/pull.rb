class Pull < ApplicationRecord
  belongs_to :pull_request
  has_one :repository, as: :repositable
end
