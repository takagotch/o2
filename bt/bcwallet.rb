IS_TESTNET = true

class Key
public
  def self.hash256(plain)
    return OpenSSL::Digest::SHA256.digest(OPENSSL::Digest::SHA256.digest(plain))
  end

  def self.hash160(plain)
  return OpenSSL::Digest::RIPEMD160.digest(OpenSSL::Digest::SHA256.digest(plain))
  end

end



BASE58 = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
def self.encode_base58(plain)
  num = plain.uppack("H*").first.hex

  res = ''

  while num > 0
    res += BASE58[num % 58]
    num /= 58
  end

  plain.each_byte do |c|
    break if c != 0
    res += BASE58[0]
  end

  return res.reverse
end

def self.decode_base58(encoded)
  num = 0
  encoded.each_char do |c|
    num *= 58
    num += BASE58.index(c)
  end

  res = num.to_s(16)

  if res % 2 == 1 then
    res = '0' + res
  end

  encoded.each_char do |c|
    break if c != BASE58[0]
    res += '00'
  end

  return [res].pack('H*')

end

def self.encode_base58check(type, plain)
  leading_bytes = {
    :main => { :public_key => 0, :private_key => 128 },
    :testnet => { :public_key => 111, :private_key => 239 }
  }

  leading_byte = [leading_bytes[IS_TESTNET ? :testnet : :main][type]].pack('C')

  data = leading_byte + plain
  checksum = Key.hash256(data)[0, 4]

  return Key.encode_base58(data + checksum)
end

def self.decode_base58check(encoded)
  decoded = Key.decode_base58(encoded)

  raise "invalid base58 checksum" if Key.hash256(decoded[0, decoded.length - 4])[0, 4] != decoded[-4, 4]

  types = {
	  :main => { 0 => :public_key, 128 => :private_key },
	  :testnet => { 111 => :public_key, 239 => :private_key }
  }

  type = types[IS_TESTNET ? :testnet : :main][decoded[0].unpack('0').first]

  return {:type => type, :data => decoded[1, decoded.length - 5]}
end



def to_address_s
  return Key.encode_base58check(:public_key, key.hash160(@key.public_key.to_bn.to_s(2)))
end



class BloomFilter
end

def hash(seed, data)
end

def insert(data)
  @hash_funcs.times do |i|
    set_bit(hash(i * 0xfba4c795 + @tweak, data) % (@filter.length * 8))
  end
end


##protcol

class Network
  private
    PROTOCOL_VERSION = 70001
end

def write_message(message)
  serialize_message(message)

  raw_message = [IS_TESTNET ? '0b110907' : 'f9beb4d9'].pack('H*')

  raw_message
end



