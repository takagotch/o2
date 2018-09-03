
class MembersControllers < ApplicationControllers

  private
  def member_params
    params.require(:member).permit(:login_name, :email, :password, :password_confirmation)
  end

end



