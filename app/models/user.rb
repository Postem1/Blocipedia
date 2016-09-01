class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  has_many :wikis
  has_many :collaborators
#  has_many :wiki_collabs, through: :collaborators, source: :wiki

  enum role: [:standard, :premium, :admin ]
  after_initialize :set_default_role

  def set_default_role
    self.role ||= :standard
  end

  after_update :publicize_wikis

  def publicize_wikis
    if self.role == 'standard'
      user_wikis = self.wikis.where(private: true)
      user_wikis.each do |wiki|
      wiki.update_attributes(private: false)
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
