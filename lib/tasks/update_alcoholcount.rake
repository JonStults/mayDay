namespace :abc do
  desc "Update the alcohol count for each user daily"
  task :update_alcoholcount => :environment do
    users = User.all
    users.each do |u|
      if Alcohol.exists?(user: u)
        alcohol = Alcohol.where(user: u).first
        if alcohol.count > 0
          alcohol.count -= 1
          alcohol.save
        end
      end
    end
    puts 'it worked YO'
  end
end
