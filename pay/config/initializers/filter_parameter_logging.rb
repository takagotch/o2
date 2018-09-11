Rails.application.config.filter_parameters +=
	[:password, :password_confirmation, :credit_card_number,
  :expiration_month, :expiration_year, :cvc]

