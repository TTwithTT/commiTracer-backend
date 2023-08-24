# frozen_string_literal: true

class StickyNote < ApplicationRecord
  belongs_to :commit
end
