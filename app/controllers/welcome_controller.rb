class WelcomeController < ApplicationController
	def index
	end

  def search
    matches = Campaign.search(params["term"]) + Performer.search(params["term"])
    render json: matches, root: false
  end
end
