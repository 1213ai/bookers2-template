class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]
  before_action :authenticate_user!, expect: [:top, :about]

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    @book_comment = BookComment.new
    
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    @user = current_user
    render  "index"
  end
  end


  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
   redirect_to book_path(@book.id)
   flash[:notice] = "You have created book successfully."
  else
    render 'edit'
  end

  end


  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

 def book_params
   params.require(:book).permit(:title, :body)
 end

  def ensure_correct_user
   @book = Book.find(params[:id])
    unless @book.user == current_user
     redirect_to "/books"
    end
  end
end