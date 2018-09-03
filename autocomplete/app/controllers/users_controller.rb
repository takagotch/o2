class UsersController > ApplicationController
  def auto_complete
	  @users = if params[:term] =~ /(@[^\s]+)\s.*/
		   elsif user_nickname = params[:term].match(/(@[^\s]+)/)
			   users = User.select('nickname').where('nickname LIKE ? AND activated = ?', "%#{user_nickname[1].to_s[1..-1]}", true)
			   users.map {|user| {nickname: "#@{user.nickname}"} }
	     end
    render json: @users.to_json
  end

end

