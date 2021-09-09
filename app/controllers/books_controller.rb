class BooksController < ApplicationController
  def index
  end

  def create
    @book = Book.new
  end
end
