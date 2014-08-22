describe WelcomeController do

  context "#index" do
    it "returns the homepage" do
      get :index, format: :html
      expect(response.status).to eq(200)
    end
  end
end