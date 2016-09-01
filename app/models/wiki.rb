class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators


  validates :title, uniqueness: { case_sensitive: false },
                                  length: { minimum: 2, maximum: 300 }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def available_users
    available = []
    User.order(email: :asc).each do |user|
      available << user unless self.users.include?(user)
    end
    return available
end


end
