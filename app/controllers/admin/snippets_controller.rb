module Admin
  class SnippetsController < AdminController
    before_action :set_snippet, only: [:edit, :update, :destroy]

    def index
      @snippets = Snippet.order("name")
    end

    def new
      @snippet = Snippet.new
    end

    def create
      @snippet = Snippet.new(snippet_params)

      if @snippet.save
        redirect_to admin_snippets_path, notice: "Saved."
      else
        render action: "new"
      end
    end

    def update
      if @snippet.update_attributes(snippet_params)
        redirect_to admin_snippets_path, notice: "Saved."
      else
        render action: "edit"
      end
    end

    def destroy
      @snippet.destroy
      redirect_to admin_snippets_path, notice: "Snippet deleted."
    end

    protected

    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    def snippet_params
      params.require(:snippet).permit(:locale, :name, :snippet)
    end
  end
end
