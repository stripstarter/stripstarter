class CampaignsController < ApplicationController

  before_filter :ensure_owner, only: [:edit, :update]
  before_filter :ensure_performer, only: [:finish, :submit]
  before_filter :ensure_owner_or_performer, only: :destroy

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.active
    @top_campaigns = Campaign.active.top(5)
    @newest_campaigns = Campaign.active.newest.first(5)
    respond_to do |format|
      format.json { render :json => @campaigns }
      format.html
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.try(:active?) || current_admin?
        format.json { render json: @campaign }
        format.html
      else
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_NOT_FOUND
          redirect_to campaigns_path
        end
      end
    end
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
    @campaign ||= Campaign.find(params[:id])
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.owner = current_user

    respond_to do |format|
      if @campaign.save
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_CREATE_SUCCESS
          redirect_to @campaign
        end
        format.json { render nothing: true, status: 200 }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    @campaign ||= Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_UPDATE_SUCCESS
          redirect_to @campaign
        end
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign ||= Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.cancel
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_DESTROY_SUCCESS
          redirect_to campaigns_path
        end
        format.json { render nothing: true, status: 200 }
      else
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_DESTROY_FAILURE
          redirect_to campaigns_path
        end
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    render json: Campaign.search(params["term"]), root: false
  end

  def finish
    @campaign ||= Campaign.find(params[:id])
  end

  def submit
    @campaign ||= Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.try(:submit_for_review)
        format.json { render nothing: true, status: 200 }
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_SUBMIT_SUCCESS
          redirect_to campaigns_path
        end
      else
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
        format.html do
          flash[:notice] = Stripstarter::Response::CAMPAIGN_SUBMIT_FAILURE
          redirect_to root_path
        end
      end
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name)
  end

  def ensure_owner
    @campaign = Campaign.find(params[:id])
    unless current_admin? || @campaign.owner == current_user
      flash[:notice] = Stripstarter::Response::UNAUTHORIZED_ACTION
      redirect_to campaigns_path
    end
    true
  end

  def ensure_performer
    @campaign = Campaign.find(params[:id])
    unless current_admin? || @campaign.performers.include?(current_user)
      flash[:notice] = Stripstarter::Response::UNAUTHORIZED_ACTION
      redirect_to campaigns_path
    end
    true
  end

  def ensure_owner_or_performer
    @campaign = Campaign.find(params[:id])
    unless current_admin? ||
           @campaign.owner == current_user ||
           @campaign.performers.include?(current_user)
      flash[:notice] = Stripstarter::Response::UNAUTHORIZED_ACTION
      redirect_to campaigns_path
    end
    true
  end
end
