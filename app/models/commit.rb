class Commit < ApplicationRecord
  belongs_to :user
  has_many :blocks, dependent: :destroy
  accepts_nested_attributes_for :blocks
  has_many :sticky_notes, dependent: :destroy

  validate :maximum_three_sticky_notes

  private

  def maximum_three_sticky_notes
    if sticky_notes.size > 3
      errors.add(:sticky_notes, "You can only have 3 sticky notes per commit.")
    end
  end
end
