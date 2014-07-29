class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index,:update,:edit,:destroy]
  before_action :correct_user, only: [:update,:edit]
  before_action :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end
  
  def index
  	#@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 20)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile edit successfully"
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:name,:email,:password,:password_confirmation)
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || current_user.admin
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "Out of priviledge" unless current_user.admin && !@user.admin?
    end
end
