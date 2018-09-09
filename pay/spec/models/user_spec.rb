describe User do

  before(:each) { @user = User.new(email: "user@ex.com") }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match "user@ex.com"
  end
end

