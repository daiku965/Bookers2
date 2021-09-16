class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @keyword = params[:keyword]
    @method = params[:method]
    if @model == 'User'
      @records = User.search_for(@keyword, @method)
    else
      @records = Book.search_for(@keyword, @method)
    end
  end
end

