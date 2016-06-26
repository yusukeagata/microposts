class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:following, :followers]

  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10).order(:id)
  end
  
  def new
    @user = User.new
  end
  
  def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user 
      else
        render 'new'
      end
  end
#def current_user
#    if (user_id = session[:user_id])
#      @current_user ||= User.find_by(id: user_id)
#    elsif (user_id = cookies.signed[:user_id])
#      user = User.find_by(id: user_id)
#      if user && user.authenticated?(cookies[:remember_token])
#        log_in user
#        @current_user = user
#      end
#    end
#end

  def edit
    @user = User.find(params[:id]) #編集しようとしたユーザー
    if (current_user != @user)
      redirect_to root_url
    end
    
    #ここで出る画面には地域などの項目が追加されているはず
  end
  
  def update
    @user = User.find(params[:id]) #編集しようとしたユーザー
    if (current_user != @user)
      redirect_to root_url
    end
    
     #edit 画面のボタンが押されたらやってくる
    if @user.update(user_params2)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users.order(created_at: :desc)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users.order(created_at: :desc)
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
 
   def user_params2
    params.require(:user).permit(:name, :email, :region, :password,
                                 :password_confirmation, )
   end 
  
end
