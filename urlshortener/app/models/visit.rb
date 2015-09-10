# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  num_visits :integer          not null
#  user_id    :integer          not null
#  url_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Visit < ActiveRecord::Base
  validates :num_visits, null: false
  validates :user_id, null: false
  validates :url_id, null: false

  belongs_to :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id

  def self.record_visit!(user,short_url)
    Visit.create!(user_id: user.id, url_id: short_url.id, num_visits: 0)
  end
end
