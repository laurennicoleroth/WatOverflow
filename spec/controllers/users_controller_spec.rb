require 'rails_helper'

describe UsersController do
  let(:eveanandi) {User.new(name: "Eveanandi", email: "meerrrrr@rrrrr.com", password: "catscatscats")}
  context 'create' do
    it 'creates a new user' do
      params = {user: {name: "Lauren", email: "DutchessofUrls@everything.com", password: "poooooooooodle"}}
      post(:create, params)
      expect(User.last.name).to eq("Lauren")
    end

    # TODO: mmmmmm uniqueness is needed on the model, I think.
    it 'redirects to sign up page when invalid' do
      eveanandi.save
      params = {user: {name:"clone", email:"meerrrrr@rrrrr.com", password:"rubberducky"}}
      post(:create, params)
      expect(response).to redirect_to signup_path
    end
  end

  context 'update' do
    it "updates existing user" do
      eveanandi.save
      params = {id: eveanandi.id, user: {name: "Eveanandi", email: "cats@4ever.com", password: "catscatscats"}}
      put(:update, params)
      expect(eveanandi.reload.email).to eq("cats@4ever.com")
    end

    it "does not update a user with wrong attributes" do
      eveanandi.save
      params = {id: eveanandi.id, user: {name: [], email: "cats@4ever.com", password: "catscatscats"}}
      put(:update, params)
      expect(eveanandi.reload.name).to_not eq([])
    end
  end

  context 'destroy' do
    it 'should delete an existing user' do
      eveanandi.save
      users = User.count
      del_user = {id: eveanandi.id}
      delete(:destroy, del_user)
      expect(User.count).to_not eq(users)
    end
  end
end