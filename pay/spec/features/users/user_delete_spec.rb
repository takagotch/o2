include Warden::Test::Helpers
Warden.test_model

feature "User delete", :devise do
  after(:each) do
    Warden.test_reset!
  end

  scenario "" do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit edit_user_registeration_path(user)
    click_button "Cancel my account"
    expect(page).to have_content I18n.t "devise.registrations.destroyed"
  end

end

