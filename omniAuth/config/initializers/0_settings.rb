class Settings < Setingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end



