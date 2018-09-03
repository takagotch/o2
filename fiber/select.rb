# readable, writable only one callback

def wait_io(event, fd)
  self[event, fd] = Fiber.current.method(:resume)
  Fiber.yield
ensure
  delete(event, fd)
end

def wait_readable(fd); wait_io(:read, fd); end

def _read(fd, sz)
  return fd.read_noblock(sz)
rescue IO::WaitReadable
  wait_readable(fd)
  retry
end



