class Repository < ApplicationRecord
  belongs_to :repositable, polymorphic: true
end
