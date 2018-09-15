class User < ApplicationRecord
 #has_many :microposts
  has_many :microposts, dependent: :destroy

  def feed
    Micropost.where("user_id = ?", id)
  end

  private

end


