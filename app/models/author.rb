class Author < ApplicationRecord
  belongs_to :authorable, polymorphic: true
end
