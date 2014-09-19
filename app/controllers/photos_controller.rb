class PhotosController < ApplicationController

  before_filter :ensure_performance_exists

  def create
    @photo = Photo.new(photo_params)
    @photo.performance = @performance
    respond_to do |format|
      if @photo.save
        format.json { render nothing: true, status: 200 }
        format.html do
          flash[:notice] = Stripstarter::Response::PHOTO_CREATE_SUCCESS
          redirect_to campaign_finish_path(params[:campaign_id])
        end
      else
        format.json { render nothing: true, status: 500 }
        format.html do
          flash[:notice] = Stripstarter::Response::PHOTO_CREATE_FAILURE
          redirect_to campaign_finish_path(params[:campaign_id])
        end
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:performance_id, :image)
  end

  def ensure_performance_exists
    # TODO: Add validation that one one performance per performer/campaign combo
    @performance = Performance.find_by(
      campaign_id: params[:campaign_id],
      performer_id: current_user.id
    )
    if @performance.nil?
      flash[:notice] = Stripstarter::Error::NoPerformance.new.message
      redirect_to campaign_finish_path(id: params[:campaign_id])
    end
  end
end