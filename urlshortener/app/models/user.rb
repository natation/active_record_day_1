# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  
  has_many :submitted_urls,
    class_name: "ShortenedUrl",
    foreign_key: :submitted_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :user_id,
    primary_key: :id

  has_many :visited_urls,
    through: :visits,
    source: :url

end