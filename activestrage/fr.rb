class Article < ApplicationRecord
  has_many_attached :images
  has_one_attached :image

end

class ArticlesController < ApplicationController
  content_security_policy do |policy|
    policy.upgrade_insecure_requests true
  end
end

