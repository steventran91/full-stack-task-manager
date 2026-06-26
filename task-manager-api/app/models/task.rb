class Task < ApplicationRecord
  belongs_to :user

  validates :title, :status, presence: true
  validates :status, inclusion: {in: ['pending', 'in_progress', 'completed']}
end
