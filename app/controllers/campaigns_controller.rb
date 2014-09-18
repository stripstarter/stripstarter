class CampaignsController < ApplicationController

  before_filter :ensure_campaign_owner, only: [:edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.all
    @top_campaigns = Campaign.top(5)
    @newest_campaigns = Campaign.newest.first(5)
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
      format.json { render :json => @campaign }
      format.html
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

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
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
        format.html { redirect_to @campaign, notice: "Campaign was successfully updated." }
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
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    render json: Campaign.search(params["term"]), root: false
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name)
  end

  def ensure_campaign_owner
    @campaign = Campaign.find(params[:id])
    if @campaign.owner_id != current_user.try(:id)
      flash[:notice] = "You are not permitted to perform this action"
      redirect_to campaigns_path
    end
    true
  end
end
