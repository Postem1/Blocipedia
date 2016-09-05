class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates :title, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 300 }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def available_users
    available = []
    User.all.find_each do |user|
      available << user unless users.include?(user)
    end
    available
  end
end
