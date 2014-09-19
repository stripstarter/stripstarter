class PhotosController < ApplicationController

  before_filter :ensure_performance_exists
  before_filter :require_admin, only: [:show, :destroy]

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

  def show
    @photo = Photo.find(params[:photo_id])
    respond_to do |format|
      format.html
      format.json { render json: @photo.to_json }
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @photo.destroy
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
      format.html do
        flash[:notice] = "Photo destroyed."
        redirect_to campaign_finish_path(@photo.campaign)
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:performance_id, :image)
  end

  def require_admin
    redirect_to root_path unless current_admin?
  end

  def ensure_performance_exists
    # TODO: Add validation that one one performance per performer/campaign combo
    @performance = Performance.find_by(
      campaign_id: params[:campaign_id],
      performer_id: current_user.id
    ) || stubbed_performance
    if @performance.nil?
      flash[:notice] = Stripstarter::Error::NoPerformance.new.message
      redirect_to campaign_finish_path(id: params[:campaign_id])
    end
  end

  def stubbed_performance
    return nil unless current_admin?
    Performance.create(
      performer_id: current_user.id,
      campaign_id: params[:campaign_id]
    )
  end
end