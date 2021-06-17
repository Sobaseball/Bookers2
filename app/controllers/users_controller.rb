class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = User.new
    @book = Book.new
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
  if  @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "Book was successfully created"
  else
    render :edit
  end
  end

  def create
    @book = Book.new(book_params)
 if @book.save
  redirect_to book_path(@book)
  flash[:notice] = "Book was successfully created"
 else
  @book = Book.all
  render 'index'
 end
  end





  private
  def user_params
      params.require(:user).permit(:name, :email, :image, :introduction)

 # introdution追加
  end
  def book_params
    params.require(:book).permit(:title,  :body)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end


