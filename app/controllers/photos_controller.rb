class PhotosController < ApplicationController

  before_filter :ensure_performance_exists, only: :create
  before_filter :require_performer_or_admin, only: [:show, :destroy]

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
        format.json { render json: @photo.errors, status: :unprocessable_entity }
        format.html do
          flash[:notice] = Stripstarter::Response::PHOTO_CREATE_FAILURE
          redirect_to campaign_finish_path(params[:campaign_id])
        end
      end
    end
  end

  def show
    @photo ||= Photo.find(params[:photo_id])
    style = params[:style] || "original"
    send_file @photo.image.url(style.to_sym).gsub(/\?\d+/,"")
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @photo.destroy
    respond_to do |format|
      format.json { render nothing: true, status: 200 }
      format.html do
        flash[:notice] = Stripstarter::Response::PHOTO_DESTROY_SUCCESS
        redirect_to campaign_finish_path(@photo.campaign)
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:performance_id, :image)
  end

  def require_performer_or_admin
    @photo = Photo.find(params[:photo_id])
    unless current_admin? || @photo.performer == current_user
      flash[:notice] = Stripstarter::Response::UNAUTHORIZED_ACTION
      redirect_to root_path
    end
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