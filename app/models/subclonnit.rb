# == Schema Information
#
# Table name: subclonnits
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  default     :boolean
#
# Indexes
#
#  index_subclonnits_on_name  (name) UNIQUE
#

class Subclonnit < ActiveRecord::Base
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  # Default subclonnits
  scope :default, -> { where(default: true) }
end
