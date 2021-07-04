class BooksController < ApplicationController

  before_action :authenticate_user!

   before_action :correct_user, only: [:edit, :update]


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @new = Book.new
    @user = User.find(current_user.id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = " successfully "
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id]) # idをもとにPost（投稿）を特定
    @user = @book.user             # 特定されたPostに紐づくUserを特定し、@userに入れる
    if current_user != @user       # 現在ログインしているユーザー（編集者）と@user（投稿者）が異なったら
      redirect_to books_path       # 一覧ページにリダイレクトさせる
    end
  end
end
