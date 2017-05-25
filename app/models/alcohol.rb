class Alcohol < ActiveRecord::Base
  belongs_to :user

  def self.count_down
    users = User.all
    if Time.zone.now == Time.zone.now.beginning_of_day
      users.each do |u|
        if Alcohol.exists?(user: u)
          alcohol = Alcohol.where(user: u).first
          if alcohol.count > 0
            alcohol.count -= 1
            alcohol.save
          end
        end
      end
    end
  end
end
