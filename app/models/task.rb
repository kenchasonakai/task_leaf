class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :user

  def my_task?(login_user)
    user == login_user
  end
end
