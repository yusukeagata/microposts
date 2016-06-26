class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :following, :followers]
  before_action :find

  def show # 追加
   @microposts = @user.microposts.order(created_at: :desc)
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
  
  def edit
    if (current_user != @user)
      redirect_to root_url
    end
    
    #ここで出る画面には地域などの項目が追加されているはず
  end
  
  def update
    if (current_user != @user)
      redirect_to root_url
    end
    
     #edit 画面のボタンが押されたらやってくる
    if @user.update(user_params2)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  def following
    @title = "Following"
    @users = @user.following_users.order(created_at: :desc)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.follower_users.order(created_at: :desc)
    render 'show_follow'
  end

  private
  
  def find
    @user  = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
 
  def user_params2
    params.require(:user).permit(:name, :email, :region, :password,
                                 :password_confirmation, )
  end 
  
end
