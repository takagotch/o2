require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
		     password: "foobar", password_confirmation: "foobar")
  end

  test "associated micorposts should be destroyed" do
    @user.save
    @user.micropost.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count',  -1 do
      @user.destroy
    end
  end

end

