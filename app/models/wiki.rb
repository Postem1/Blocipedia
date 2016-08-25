class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, uniqueness: { case_sensitive: false },
                                  length: { minimum: 2, maximum: 300 }

end
