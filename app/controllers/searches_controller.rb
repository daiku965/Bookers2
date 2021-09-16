class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @keyword = params[:keyword]
    @method = params[:method]
    @records = search_for(@model, @keyword, @method)
  end

  private

  def search_for(model, keyword, method)
    if model == 'User'
      if method == 'exact'
        User.where(name: keyword)
      elsif method == 'forward'
        User.where('name LIKE ?', '%'+keyword)
      elsif method == 'backword'
        User.where('name LIKE ?', keyword+'%')
      else
        User.where('name LIKE ?', '%'+keyword+'%')
      end
    elsif model == 'Book'
      if method == 'exact'
        Book.where(title: keyword)
      elsif method == 'forward'
        Book.where('title LIKE ?', '%'+keyword)
      elsif method == 'backword'
        Book.where('title LIKE ?', keyword+'%')
      else
        Book.where('title LIKE ?', '%'+keyword+'%')
      end
    end
  end
end

