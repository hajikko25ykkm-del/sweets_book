class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post =Post.new
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end
end
