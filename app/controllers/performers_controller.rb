class PerformersController < ApplicationController

  def show
    @performer = Performer.find(params[:performer_id])
    respond_to do |format|
      format.html do
        @user = @performer
        render 'users/show'
      end
      format.json {render json: @performer}
    end
  end

  def search
    render json: Performer.search(params["term"]), root: false
  end
end