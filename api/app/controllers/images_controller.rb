class ImageController < ApplicationController
  def index
    page = Mechanize.new.get "https://www.google.co.jp/search?q=#{params[:q]}&tbm=isch"
    image_path = page.at('img').get_attribute :src
    render json: { image_path: image_path }
  end
end

