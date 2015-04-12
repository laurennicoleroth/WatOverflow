module AuthenticationHelpers
  def stub_current_user user
    ApplicationController.any_instance.stub(:current_user) { user }
  end

  def stub_authorize_user!
    ApplicationController.any_instance.stub(:authorize) { true }
  end
end
