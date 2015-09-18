# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  url           :string
#  text          :text
#  user_id       :integer
#  subclonnit_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_posts_on_subclonnit_id  (subclonnit_id)
#  index_posts_on_user_id        (user_id)
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subclonnit
  has_many :upvotes
  has_many :downvotes

  # Validations
  validates :url,   format: URI.regexp(%w(http https)), unless: 'url.blank?'
  validates :title, presence: true

  def total_votes
    upvotes.size - downvotes.size
  end
end
