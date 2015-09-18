# == Schema Information
#
# Table name: moderators
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  subclonnit_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_moderators_on_subclonnit_id  (subclonnit_id)
#  index_moderators_on_user_id        (user_id)
#

class Moderator < ActiveRecord::Base
  belongs_to :user
  belongs_to :subclonnit
end
