# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitted_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, null: false, uniqueness: true
  validates :short_url, null: false
  validates :submitted_id, null: false

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitted_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  has_many :visitors, through: :visits, source: :user

  def self.random_code
    base64_str = nil
    while base64_str.nil? || ShortenedUrl.exists?(short_url: base64_str)
      base64_str = SecureRandom.urlsafe_base64
    end
    base64_str
  end

  def self.create_for_user_and_long_url!(user,long_url)
    short_url = self.random_code
    ShortenedUrl.create!(
                        long_url: long_url,
                        submitted_id: user.id,
                        short_url: short_url
                        )
  end


end
