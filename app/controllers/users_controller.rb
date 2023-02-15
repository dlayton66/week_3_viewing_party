class UsersController <ApplicationController 
  before_action :validate_user, only: :show

  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(session[:user_id])
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end

  private 

  def user_params 
    params[:email]&.downcase!
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 