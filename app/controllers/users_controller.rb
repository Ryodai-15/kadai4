class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]


  def new
    @user = User.new
  end

  def create
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book
  end

  def show
    @user = User.find(params[:id])
    #@books = @user.books.page(params[:page])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end

  #自身がフォロー中のユーザーを表示
  def following
    @user  = User.find(params[:id])
    @users = @user.following_user
    #@users = @user.following
    #render 'show_follow'
  end

  #自身をフォロー中のユーザーを表示
  def followers
    @user  = User.find(params[:id])
    @users = @user.follower_user
    #@users = @user.followers
    #render 'show_follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction,:profile_image)
  end

  def correct_user
    @user = User.find(params[:id]) # idをもとにPost（投稿）を特定
    if current_user != @user       # 現在ログインしているユーザー（編集者）と@user（投稿者）が異なったら
      redirect_to user_path(current_user.id)      # 一覧ページにリダイレクトさせる
    end
  end

end
