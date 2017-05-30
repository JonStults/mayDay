class Success < ActiveRecord::Base
  belongs_to :user
  scope :today, -> { where(:updated_at => (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)) }
end
