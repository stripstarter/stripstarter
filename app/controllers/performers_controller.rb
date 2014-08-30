class PerformersController < ApplicationController
  def search
    render json: Performer.search(params["term"])
  end
end