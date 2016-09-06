class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

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
