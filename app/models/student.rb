class Student < ApplicationRecord
  belongs_to :teacher

  validates :name, :subject_name, :marks, presence: true
  validates :marks, numericality: { greater_than_or_equal_to: 0 }
end
