class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show]

  def blog
    @heading_a = t('blog_posts_controller.blog_heading')
    @blog_posts = BlogPost.where(visible: true).paginate(page: params[:page], order: 'created_at DESC')
    not_found unless admin? || @w.blog_visible?
  end

  def show
    not_found unless admin? || @w.blog_visible?
    @content = Liquid::Template.parse(@blog_post.content).render
  end

  def feed
    @blog_posts = BlogPost.visible_posts
  end

  protected

    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end
end
