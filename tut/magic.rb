class Admin::BaseController < InheritedResources::Base
end

module InheritedResourcesRemoval
  InheritedResourcesUsed = Class.new(StandardError)

  def index(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

  def show(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

  def new(options = {}, &block)
    Honeybager.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

  def edit(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

  def create(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}`"))
    super(options, &block)
  end

  def update(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

  def destroy(options = {}, &block)
    Honeybadger.notify(InheritedResourcesUsed.new("Inherited resources used at controller `#{params[:controller]}` and action `#{params[:action]}`"))
    super(options, &block)
  end

end



module InheritedResources
  module Actions
    prepend(::InheritedResourcesRemoval)
  end

end



