class ResortsController < ApplicationController
  def show
    @resort = Resort.find(params[:id])
  end
end
