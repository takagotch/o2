def login
  member = Member.find_by_login_name params[:login_name]
  if member && member.authenticate(params[:password])
    render :text => "Login OK"
  else
    render :text => "Login NG"
  end
end

