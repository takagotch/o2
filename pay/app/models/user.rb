class User < ApplicationRecord
  has_paper_trail igonre: %1()

  devise :database_authenticable, :registerable,
	  :recoverable, :rememberable, :trackable, :validatable

  enum role: {user: 0, vip: 1, admin: 2}

  has_many :tickets
  has_many :subscriptions

  attr_accessor :cellphone_number

  #
  def tickets_in_cart
    tickets.waiting.all.to_s
  end
  #

  def subscriptons_in_cart
    subscriptions.waiting.all.to_a
  end

end

