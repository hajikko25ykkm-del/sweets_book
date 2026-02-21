class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:index]

  def index
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @results = User.where("name LIKE ?", "%#{@word}%")
    elsif @range == "Post"
      @results = Post.where("title LIKE ? OR body LIKE ?", "%#{@word}%", "%#{@word}%")
    else
      @results = []
    end
  end
end
