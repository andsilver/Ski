class SnippetsController < ApplicationController
  before_filter :admin_required
  before_filter :find_snippet, only: [:edit, :update, :destroy]
  before_filter :no_browse_menu

  def index
    @snippets = Snippet.order('name')
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(params[:snippet])

    if @snippet.save
      redirect_to snippets_path, notice: 'Saved.'
    else
      render action: 'new'
    end
  end

  def update
    if @snippet.update_attributes(params[:snippet])
      redirect_to snippets_path, notice: 'Saved.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @snippet.destroy
    redirect_to snippets_path, notice: 'Snippet deleted.'
  end

  protected

  def find_snippet
    @snippet = Snippet.find_by_id(params[:id])
  end
end
