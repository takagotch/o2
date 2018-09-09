feature "Sign out", :devise do
  scenario "Sign out" do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content I18n.t "devise.sessions.signed_in"
    click_link "Sign out"
    expect(page).to have_content I18n.t "devise.sessions.signed_out"
  end

end

