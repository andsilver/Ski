class Admin::BlogPostsController < ApplicationController
  before_action :admin_required
  layout 'admin'

  before_action :set_blog_post, only: [:edit, :update]

  def index
    @blog_posts = BlogPost.order('created_at DESC')
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to(admin_blog_posts_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog_post.update_attributes(blog_post_params)
      redirect_to(edit_admin_blog_post_path(@blog_post), notice: t('notices.saved'))
    else
      render "edit"
    end
  end

  protected

    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    def blog_post_params
      params.require(:blog_post).permit(:content, :headline, :image_id)
    end
end
