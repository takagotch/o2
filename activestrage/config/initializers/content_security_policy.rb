Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.style_src :self, https, :unsafe_inline

end

