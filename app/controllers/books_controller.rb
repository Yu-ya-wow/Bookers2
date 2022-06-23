class BooksController < ApplicationController

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def show
    @book=Book.new
    @books=Book.find(params[:id])
    @user=@books.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books=Book.all
    @user=current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end