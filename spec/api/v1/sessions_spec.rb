require 'spec_helper'

describe "/api/v1/sessions" do
  let(:url) { "/api/v1" }

  before do
    @user = create(:user)
  end

  it "creates a new session when the request contains valid credentials"  do
    api_sign_in(url, @user)
    expect(last_response.status).to eq(201)
    expect(User.last.authentication_token).not_to be_nil
  end

  it "does not create a new session when the request contains invalid credentials"  do
    @user_with_wrong_credentials = build(:user, password: "wrongpassword")
    api_sign_in(url, @user_with_wrong_credentials)
    expect(last_response.status).to eq(401)
    expect(User.last.authentication_token).to be_nil
  end

  it "destroys a session and invalidates the authentication token" do
    api_sign_out(url, @user)
    expect(last_response.status).to eq(204)
    expect(User.last.authentication_token).to be_nil
  end

end
