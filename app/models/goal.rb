class Goal < ActiveRecord::Base
  belongs_to :user

  def completed=(boolean)
    self.completed_at = boolean ? Time.zone.now : nil
  end

  def completed
    completed_at && completed_at >=   Time.zone.now.beginning_of_day
  end
end
