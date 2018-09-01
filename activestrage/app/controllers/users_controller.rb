def user_params
  params.require(:user).permit(:name, :address, :avatar)
end


