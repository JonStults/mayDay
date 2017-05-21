class GoalsController < ApplicationController
  def index
    render 'index'
  end

  def view_profile
    @user = User.find_by_id(params[:id])
    @goals = Goal.where(user: @user)
    @messages = Message.where(recipient: @user)
    render 'profile'
  end

  def create
    user = User.create(f_name:params[:f_name],l_name:params[:l_name],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation])
    if !user.errors.blank?
      puts "********"
      puts user.errors.messages
      puts "********"
      flash[:errors] = user.errors.messages
      return redirect_to '/'
    end
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      return redirect_to '/show'
      # flash[:notice] = "Registration Successful, please log in."
    else
      flash.now[:errors] = 'Invalid email/password combination'
      return redirect_to '/'
    end
    return redirect_to '/show'
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
    puts '**********'
    puts user.id
    puts '**********'
    Message.create(content: params[:content], recipient: user, sender: sender)
    redirect_to "/view_profile/#{user.id}"
  end

  def complete_goal
    puts 'made it to complete goal'
    goal = Goal.find_by_id(params[:goal_id])
    puts '********'
    puts goal.content
    puts '********'
    goal.completed = true
    goal.save
    puts 'goal saved'
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
    if Alcohol.exists?(user: user)
      alcohol = Alcohol.where(user: user).first
      alcohol.count += 7;
      alcohol.save
    else
    Alcohol.create(count: 7, user: user)
    end
    redirect_to "/show"
  end

  def show
    @user = User.find_by_id(session[:user_id])
    # goal = Goal.first
    @users = User.all
    # # @goal = Goal.where(id: goal, user: @user)
    # puts '**************'
    # puts @goal
    # puts '**************'
    if Goal.exists?(user: @user)
      @goals = Goal.where(user: @user)
    end
    if Alcohol.exists?(user: @user)
      @count = Alcohol.where(user: @user).first
    end
    render 'goals'
  end
end
