json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :title
  json.url campaign_url(campaign, format: :json)
end
