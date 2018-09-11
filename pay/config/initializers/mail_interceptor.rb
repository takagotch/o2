unless Rails.env.test? || Rails.env.production?

  options = {forward_emails_to: "noe@noe.com",
	     deliver_emails_to: ["@snowglobe.com"]}

  interceptor = MailInterceptor::Interceptor.new(options)
  ActionMailler::Base.register_interceptor(interceptor)

  EmailPrefixer.configure do |config|
    config.application_name = "Snow Globe"
  end

end

