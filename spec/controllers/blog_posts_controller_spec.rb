require 'spec_helper'

describe BlogPostsController do
  describe 'GET feed' do
    it 'finds all visible blog posts' do
      BlogPost.should_receive(:visible_posts)
      get 'feed', format: 'xml'
    end

    it 'assigns @blog_posts' do
      posts = BlogPost.new
      BlogPost.stub(:visible_posts).and_return(posts)
      get 'feed', format: 'xml'
      assigns('blog_posts').should == posts
    end
  end
end
