# frozen_string_literal: true

class Commit < ApplicationRecord
  belongs_to :user
  has_many :blocks, dependent: :destroy
  accepts_nested_attributes_for :blocks
  has_many :sticky_notes, dependent: :destroy

  validate :maximum_three_sticky_notes

  private

  def maximum_three_sticky_notes
    errors.add(:sticky_notes, 'You can only have 3 sticky notes per commit.') if sticky_notes.size > 3
  end
end
