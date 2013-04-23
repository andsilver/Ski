class BlogPostsController < ApplicationController
  before_filter :admin_required, except: [:blog, :show, :feed]
  before_filter :find_blog_post, only: [:show, :edit, :update]
  before_filter :no_browse_menu

  def index
    @blog_posts = BlogPost.order('created_at DESC')
  end

  def blog
    @heading_a = t('blog_posts_controller.blog_heading')
    @blog_posts = BlogPost.where(visible: true).paginate(page: params[:page], order: 'created_at DESC')
    not_found unless admin? || @w.blog_visible?
  end

  def show
    not_found unless admin? || @w.blog_visible?
    @content = Liquid::Template.parse(@blog_post.content).render
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to(blog_posts_path, notice: t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @blog_post.update_attributes(blog_post_params)
      redirect_to(edit_blog_post_path(@blog_post), notice: t('notices.saved'))
    else
      render "edit"
    end
  end

  def feed
    @blog_posts = BlogPost.visible_posts
  end

  protected

  def find_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:content, :headline, :image_id)
  end
end
