class ResortsController < ApplicationController
  def show
    @browse_resort = @resort = Resort.find(params[:id])
  end
end
