class BooksController < ApplicationController
  before_action :correct_book, only:[:edit]


  def index
    @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @newbook=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "The book has been successfully created"
    redirect_to book_path(@book.id)
    else
    @user=current_user
    @books=Book.all
    render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "The book has been successfully updated"
    redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end

end
