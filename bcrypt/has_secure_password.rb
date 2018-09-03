Digest::MD5.hexdigest('password')

Digest::SHA256.hexdigest('salt-password-salt')

def stretching(str, n = 0)
  str = Digest::SHA256.hexdigest(str) 
  return str 
  if n > 1000
  stretching(str, n + 1) 
  end
  stretching('salt-password-salt')
end


