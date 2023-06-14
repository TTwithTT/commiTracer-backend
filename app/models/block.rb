class Block < ApplicationRecord
  belongs_to :commit
  enum status: { onqueue: 0, running: 1, done: 2 }
end
