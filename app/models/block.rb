class Block < ApplicationRecord
  enum status: { onqueue: 0, running: 1, done: 2 }
end
