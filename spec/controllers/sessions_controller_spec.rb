require 'rails_helper'

describe SessionsController do
  let(:eveanandi) {User.create(name: "Eveanandi", email: "meerrrrr@rrrrr.com", password: "catscatscats")}
  before(:each) do
    stub_current_user eveanandi
    stub_authorize_user!
  end

  context "create" do
    it "redirects to root path after logging in" do
      params = {email: eveanandi.email, password: eveanandi.password}
      p params
      post(:create, params)
      expect(response).to redirect_to root_path
    end

    it "redirects to login path after bad login in" do
      params = {email: "WAHHHHH@cry.com", password: "allthedogs"}
      post(:create, params)
      expect(response).to redirect_to login_path
    end
  end

  context "destroy" do
    it "logs out the user" do
      delete(:destroy)
      expect(response).to redirect_to login_path
    end
  end

end