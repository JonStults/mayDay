class GoalsController < ApplicationController
  def index
    render 'index'
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def view_profile
    if ! session[:user_id]
      redirect_to "/"
      return
    end
    @user = User.find_by_id(params[:id])
    @current_user = User.find_by_id(session[:user_id])
    @goals = Goal.where(user: @user)
    @messages = Message.where(recipient: @user)
    @success = Success.where(user: @user).first
    render 'profile'
  end

  def create
    user = User.create(f_name:params[:f_name],l_name:params[:l_name],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation], avatar: params[:avatar])
    if !user.errors.blank?
      flash[:errors] = user.errors.messages
      return redirect_to '/'
    end
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      return redirect_to '/show'
    else
      flash.now[:errors] = 'Invalid email/password combination'
      return redirect_to '/'
    end
    return redirect_to '/show'
  end

  def avatar
    puts 'this is avatar', params[:user][:avatar]
    puts '********'
    puts 'reached avatar'
    puts '********'
    user = User.find_by_id(params[:id])
    puts 'this is the user', user.id
    user.avatar = params[:user][:avatar]
    puts 'this is the user avatar', user.avatar
    user.save
    if user.save
      puts '******'
      puts 'user was saved!'
    else
      puts '%%%%%%%%'
      raise user.errors.to_yaml
      puts 'user was not saved!'
    end
    puts '********'
    puts params[:user][:avatar]
    puts 'saved avatar'
    puts '********'
    redirect_to "/view_profile/#{user.id}"
  end

  def add_goal
    user = User.find_by_id(session[:user_id])
    Goal.create(content: params[:content], user: user)
    redirect_to '/show'
  end

  def log_user
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/show"
    else
      flash[:log_error] = 'Invalid email/password combination'
    return redirect_to '/'
    end
  end

  def logout
    reset_session
    redirect_to '/'
  end

  def post_message
    user = User.find_by_id(params[:user_id])
    sender = User.find_by_id(session[:user_id])
    Message.create(content: params[:content], recipient: user, sender: sender)
    redirect_to "/view_profile/#{user.id}"
  end

  def complete_goal
    goal = Goal.find_by_id(params[:goal_id])
    goal.completed = true
    goal.save
    redirect_to "/show"
  end

  def incomplete_goal
    goal = Goal.find_by_id(params[:goal_id])
    goal.completed = false
    goal.save
    redirect_to "/show"
  end

  def failed
    user = User.find_by_id(session[:user_id])
    if ! Alcohol.exists?(user: user)
      Alcohol.create(count: 7, user: user)
    end
    if ! Alcohol.today.exists?(user: user)
      alcohol = Alcohol.where(user: user).first
      alcohol.count += 7;
      alcohol.save
    end
    success = Success.where(user: user).first
    if success
      success.days = 0
      success.save
    end
    flash[:alert] = "Everyone expected your dumbass to fail!"
    redirect_to "/show"
  end

  def show
    count = 0
    if ! session[:user_id]
      redirect_to "/"
      return
    end
    @user = User.find_by_id(session[:user_id])
    @users = User.all
    goals = Goal.where(user: @user)

    if Goal.exists?(user: @user)
      @goals = Goal.where(user: @user)
    end
    if Alcohol.exists?(user: @user)
      alcohol = Alcohol.where(user: @user).first
      if alcohol.count > 0
        @count = alcohol
      end
    end
    Alcohol.count_down
    Goal.count

    goals.each do |g|
      if g.completed == true
        count += 1
        puts 'this is the count', count
      end
      if count == @goals.length
        flash[:success] = "Congratulations on completing today's goals, no one thought you could do it!"
        if ! Success.exists?(user: @user)
          Success.create(days: 1, user: @user)
        end
        if ! Success.today.exists?(user: @user)
          success = Success.where(user: @user).first
          success.days += 1;
          success.save
        end
      end
    end
    render 'goals'
  end

  def destroy
    user = User.find_by_id(session[:user_id])
    goal = Goal.find_by_id(params[:goal_id])
    goal.destroy
    redirect_to "/view_profile/#{user.id}"
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:id, :f_name, :l_name, :email, :password, :password_confirmation, :avatar)
  # end
end
