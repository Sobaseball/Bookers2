class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
    if @book.save
    redirect_to book_path(@book)
    flash[:notice] = "Book was successfully created"
    else
    render:'index'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path

  end

  def update
    @book = Book.find(params[:id])
  if  @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:notice] = "Book was successfully created"
  else
    render :edit
  end
  end

   private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    unless current_user.id == @book.user_id
    redirect_to books_path
    end
  end


end
