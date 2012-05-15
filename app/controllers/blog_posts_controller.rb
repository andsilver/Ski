class BlogPostsController < ApplicationController
  before_filter :admin_required, :except => [:blog, :show]
  before_filter :find_blog_post, :only => [:show, :edit, :update]
  before_filter :no_browse_menu

  def index
    @blog_posts = BlogPost.order('created_at DESC').all
  end

  def blog
    @heading_a = t('blog_posts_controller.blog_heading')
    @blog_posts = BlogPost.paginate :page => params[:page], :order => 'created_at DESC'
    not_found unless admin? || @w.blog_visible?
  end

  def show
    not_found unless admin? || @w.blog_visible?
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(params[:blog_post])

    if @blog_post.save
      redirect_to(blog_posts_path, :notice => t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @blog_post.update_attributes(params[:blog_post])
      redirect_to(blog_posts_path, :notice => t('notices.saved'))
    else
      render "edit"
    end
  end

  protected

  def find_blog_post
    @blog_post = BlogPost.find(params[:id])
  end
end
