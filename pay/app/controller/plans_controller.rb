class PalnsController < ApplicationController
  
  def index
    @plans = Plan.active.all
  end

end

