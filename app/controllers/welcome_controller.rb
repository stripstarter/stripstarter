class WelcomeController < ApplicationController
	def index
    @top_campaigns = Campaign.top(5)
	end

  def search
    matches = Campaign.search(params["term"]) + Performer.search(params["term"])
    render json: matches, root: false
  end
end
