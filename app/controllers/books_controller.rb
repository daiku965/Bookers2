class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def create
    @book = Book.new
  end
end
