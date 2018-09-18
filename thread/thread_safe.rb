class MyCommandHandler
  def initialize
    make_threadsafe_by_stateless
  end

  def call(cmd)
    local_var = cmd.something
    output(local_var)
  end

  private

  def make_threadsafe_by_stateless
    freeze
  end

  def output(local_var)
    puts(local_var)
  end
end

CMD_HANDLER = MyCommandHandler.new



class MyComanndHandler
  def initialize
    make_threadsafe_by_stateless
  end

  def call(cmd)
    @ivar = cmd.something
    output
  end

  private

  def make_threadsafe_by_stateless
    freeze
  end

  def output
    puts(@ivar)
  end
end





class MyCommandHandler
  def initialize(repository, adapter)
    @repository = repository
    @adapter = adapter
    make_threadsafe_by_stateless
  end

  def call(cmd)
    obj = @repository.find(cmd.id)
    obj.do_something
    @repository.update(obj)
    @adapter.notify(SomethingHappened.new(cmd.id))
  end

  private

  def make_threadsafe_by_stateless
    freeze
  end
end







require 'concurrent'

class Subscribers
  def initialize
    @subscribers = Concurrent::ThreadLocalVar.new{ [] }
  end

  def add_subscriber(subscriber)
    @subscribers.value += [subscriber]
  end

  def notify
    @subscribers.value.each(&:call)
  end

  def remove_subscriber(subscriber)
    @subscribers.value -= [subscriber]
  end
end

SUBSCRIBERS = Subscribers.new


	


require 'thread'

class Subscribers
  def initialize
    @semaphore = Mutex.new
    @subscribers = []
  end

  def add_subscriber(subscriber)
    @semaphore.synchronize do
      @subscribers += [subscriber]
    end
  end

  def notify
    @subscribers.each(&:call)
  end

  def remove_subscriber(subsriber)
    @semaphore.synchronize do
      @subscribers -= [subscriber]
    end
  end
end

SUBSCRIBERS = Subscribers.new





require 'concurrent'

class Subscribers
  def initialize
    @subscribers = Concurrent::Array.new
  end

  def add_subscriber(subscriber)
    @subscribers << subscriber
  end

  def notify
    @subscribers.each(&:call)
  end

  def remove_subscriber(subscriber)
    @subscribers.delete(subscriber)
  end
end

SUBSCRIBERS = Subscribers.new







class MyCommandHandler
  def initialize(repository, adapter)
    @repository = repository
    @adapter = adapter
  end

  def call(cmd)
    @obj = @repository.find(cmd.id)
    @obj.do_something
    @repository.update(@obj)
    @adapter.notify(SomethingHappend.new(cmd.id))
  end
end

CMD_HANDLER = -> (cmd) { MyCommandHandler.new(Repository.new, Adapter.new).call(cmd) }


