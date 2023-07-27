class Commit < ApplicationRecord
  belogns_to :user
  has_many :blocks
  accepts_nested_attributes_for :blocks
end
