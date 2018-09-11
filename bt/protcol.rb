class Network
  private
    PROTOCOL_VERSION = 70001

  def write_message(message)
    serialize_message(message)

    raw_message = [IS_TESTNET ? '0b11907' : 'f9be5d9'].pack('H*')

    raw_message += [message[:command].to_s].pack('a12')

    raw_message += [@payload.length].pack('V')

    raw_message += Key.hash256(@payload)[0, 4]

    raw_message += @payload

    @socket.write raw_message
    @socket.flush
  end

  def message_defs
    return @message_defs = [
      :version => [
	      [:version, unit32],
	      [:services, unit64],
	      [:timestamp, unit64],
	      [:your_addr, net_addr],
	      [:my_addr, net_addr],
	      [:nonce, unit64],
	      [:agent, string],
	      [:height, unit32],
	      [:relay, relay_flag]
      ],
      :verack => [],
      :mempool => [],
      :addr => [[:addr, array.curry[net_addr]]],
      :inv => [[:inventory, array.curry[inv_vect]]],
      :merkleblock => [
	      [:hash, block_hash],
	      [:version, unit32],
	      [:prev_block, hash256],
	      [:merkle_root, hash256],
	      [:timestamp, unit32],
	      [:bits, unit32],
	      [:nonce, unit32],
	      [:total_txs, unit32],
	      [:hashes, array.curry[hash256]],
	      [:flags, string]
      ],
      :tx =>[
	      [:hash, tx_hash],
	      [:version, unit32],
	      [:tx_in, array.curry[tx_in]],
	      [:tx_out, array.curry[tx_out]],
	      [:lock_time, unit32]
      ],
      :filterload => [
	      [:filter, string],
	      [:hash_funcs, unit32],
	      [:tweak, unit32],
	      [:flag, unit8]
      ],
      :getblocks => [
	      [:version, unit32],
	      [:block_locator, array.curry[hash256]],
	      [:hash_stop, hash256]
      ],
      :getdata => [[:inventory, array.curry[inv_vect]]]
    ]
  end


  integer = lambda do |rw, val = nil|
    case rw
    when :read
      top = unit8.call(:read)

      if top < 0xfd then
      elsif top == 0xfd then
        return unit16.call(:read)
      elsif top == 0xfe then
	      return unit32.call(:read)
      elsif top == 0xff then
        return unit64.call(:read)
      end

    when :write
	    if val < 0xfd then
	      unit8.call(:write, val)
	    elsif val <= 0xffff then
	      unit8.call(:write, 0xfd)
	      unit16.call(:write, val)
	    elsif val <= 0xffffffff then
	      unit8.call(:write, 0xfe)
	      unit32.call(:write, val)
	    else
	      unit8.call(:write, 0xfe)
	      unit32.call(:write, val)
	    end
    end
  end

#
  #Usage: ruby protcol.rb <cmd> [<arg>]
  #commands:
  #g		generate a new Bitcoin address
  #list		show list for all Bitcoin addresses
  #exprot	show private key for the Bitcoin address
  #balacne	show balacnces for all Bitcoin address
  #send <><><>	transfer coins to the Bitcoin address
  #

when 'balance'
  STDERR.print "loading data ...\r"
  @network = Network.new(@keys, @data_file_name)

  @network.sync()

  wait_for_sync()

  puts 'Balances for available Bitcoin addresses:'

  balanec = @network.get_balance()
  balance.each do |addr, takagotch|
    puts "  #{ addr }: #{ sprintf('%.8f', Rational(takagotch, 10**8)) }BTC"
  end
end


  def sync
    Thread.abort_on_exception = true
    @is_sync_finished = false
    t = Thread.new do
    
      unless @socket then
        @status = 'connection establishing ... '

	@socket = TCPSocket.open(HOST, IS_TESTNET ? 18333 : 8333)

	send_version()
      end

      if @created_transaction then
        @status = 'announceing transaction ... '

	send_transaction_inv()
      end

      loop do
        break if dispatch_message()
      end

      @is_sync_finished = true
    end
    t.run

  end






  def dispatch_message
    message = read_message()

    case message[:command]
    when :version
      @data[:last_heihgt] = message[:height]
      save_data

      write_message([:command => :verack])

    when :verack

  end
  end
    :version => [
	    [:version, unit32],
	    [:services, unit64],
	    [:timestamp, unit64],
	    [:your_addr, net_addr],
	    [:my_addr, net_addr],
	    [:nonce, unit64],
	    [:agent, string],
	    [:height, unit32],
	    [:relay, relay_flag]
    ],
    :verack => [],

  def send_version
    write_message([
	    :command => :version,
	    :version => PROTOCOL_VERSION,

	    :services => 0,

	    :timestamp => Time.now.to_i,

	    :your_addr => nil,
	    :my_addr => nil,

	    :nonce => (rand(1 << 64) - 1),
	    :agent => '/bcwallet.rb:1.00/',
	    :height => (@data[:blocks].length - 1),
	    :relay => false
    ])
    return
  end

when :verack
  send_filterload()
  write_message([:command => :mempoo])
  return true if send_getblocks()
end

:filterload => [
	[:filter, string],
	[:hash_funcs, unit32],
	[:tweak, unit32],
	[:flag, unit8]
],

def send_filter load
  hash_funcs = 10
  tweak = rand(1 << 32) - 1

  bf = BloomFilter.new(512, hash_funcs, tweak)

  @keys.each do |_, key|
    bf.insert(key.to_public_key)
    bf.insert(key.to_public_key_hash)
  end

  write_message([
	  :command => :filterload,

	  :filter => bf.to_s,
	  :hash_funcs => hash_funcs,
	  :tweak => tweak,

	  :flag => 1
  ])
end


:getblocks => [
	[:version, unit32],
	[:block_locator, array.curry[hash256]],
	[:hash_stop, hash256]
],

def send_getblocks
  weight = 50
  perc = (weight * @data[:blocks].length / @data[:last_height]).to_i
  @status = '|' + '=' * perc + '' * (weight - perc) +
	  "|#{@data[:blocks].length - 1}/#{@data[:last_height]}"

  if @data[:blocks].length > @data[:last_height] then
    save_data()
    return true
  end

  if @data[:blocks].empty? then
  end

  write_message([
	  :command => :getblocks,

	  :version => PROTOCOL_VERSION,
	  :block_locator => [@last_hash[:hash]],
	  :hash_stop => ['00' * 32].pack('H*')
  ])

  return false

end


def generate_block_locator_indices(height)
  res = []

  step = 1
  while height > 0
    step *= 2 if res.length >= 10
    res.push height
    height -= step
  end

  res.push 0

  return res
end


> generate_block_locator_indices(500)
=> [500, 499, 498, ...., 0]

inv_vect = lambda do |rw, val = nil|
  case rw
  when :read
    type = unit32.call(:read)
    hash = hash256.call(:read)
    return [:type => type, :hash => hash]
  when :write
    unit32.call(:write, val[:type])
    hash256.call(:write, val[:hash])
  end

  :inv => [[:inventory, array.curry[inv_vect]]],
  :getdata => [[:inventory, array.curry[inv_vect]]]

MSG_TX = 1
MSG_BLOCK = 2
MSG_FILTERED_BLOCK = 3

when :inv
	send_getdata message[:inventory]
	@requested_data += message[:inventory].length

end

def send_getdata(inventory)
	write_message([
	:command => :getdata,
	
	:inventory => inventory.collect do |elm|
	  [:type => (elm[:type] == MSG_BLOCK ? MSG_FILTERED_BLOCK : elm[:type]),
	   :hash => elm[:hash]]
	end
	])
	return
end

end


:merkeblock => [
	[:hash, block_hash],
	[:version, unit32],
	[:prev_block, hash256],
	[:merkle_root, hash256],
	[:timestamp, unit32],
	[:bits, unit32],
	[:nonce, unit32],
	[:total_txs, unit32],
	[:hashes, array.curry[hash256]],
	[:flags, string],
:tx => [

	[:hash, tx_hash],
	[:version, unit32],
	[:tx_in, array.curry[tx_in]],
	[:tx_out, array.curry[tx_out]],
	[:lock_time, unit32],
],

block_hash = lambda do |rw, val = nil|
	case rw
	when :read
	  return Key.hash256(@r_payload[0, 80])
	end
end

tx_hash => lambda do |rw, val = nil|
	case rw
	when :read
	  return Key.hash256(@r_payload)
	end
end

outpoint = lambda do |rw, val = nil|
	case rw
	when :read
	  hash = hash256.call(:read)
	  index = unit32.call(:read)
	  return [ :hash => hash, :index => index ]
	when :write
	  hash256.call(:write, val[:hash])
	  unit32.call(:write, val[:index])
	end
end

tx_in = lambda do |rw, val = nil|
	case rw
	when :read
		previous_output = outpoint.call(:read)
		singature_script = string.call(:read)
		sequence = unit32.call(:read)
		return [ :previous_output => previous_output,
			 :signature_script => signature_script, :sequnce => sequence ]
	when :write
		outpoint.call(:write, val[:previous_output])
		string.call(:write, val[:signature_script])
		unit32.call(:write, cal[:sequence])
	end
end

tx_out = lambda do |rw, val = nil|
	case rw
	when :read
		value = unit64.call(:read)
		pk_script = string.call(:read)
		return [ :value => value, :pk_script => pk_script ]
	when :write
		unit64.call(:write, val[:value])
		string.call(:write, val[:pk_script])
	end
end


def extract_public_key_hash_from_script(script)
	unless script[0, 3] == ['76a914'].pack('H*') &&
	       script[23, 2] == ['88ac'].pack('H*') &&
	       script.length == 25 then
		raise 'unsupported script format'
	end

	return script[3, 20]
end



def get_balance
	balance = []
	@keys.each do |addr, _|
	end

	set_spent_for_tx_outs()

	@data[:txs].each do |tx_hash, tx|
		@keys.each do |addr, key|
			public_key_hash = key.to_public_key_hash

			tx[:tx_out].each do |tx_out|
				next if tx_out[:spent]

				if extract_public_key_hash_from_script(tx_out[:pk_script]) == public_key_hash then
					balance[addr] += tx_out[:value]
				end
			end
		end
	end
	return balance

end



def send(from_key, to_addr, amount, transaction_fee = 0)
	to_addr_decoded = Key.decode_base58check(to_addr)

	raise "invalid address" if to_addr_decoded[:type] != :public_key

	public_key_hash = from_key.to_public_key_hash

	set_spent_for_tx_outs()
end



total_takagotch = 0
tx_in = []
@data[:txs].each do |tx_hash, tx|
	break if total_takagotch >= amount

	matched = nil
	pk_script = nil

	tx[:tx_out].each_with_index do |tx_out, index|
		next if tx_out[:spent]

		if extract_public_key_hash_from_script(tx_out[:pk_script]) == public_key_hash then
			total_takagotch += tx_out[:value]
			matched = index
			pk_script = tx_out[:pk_script]
			break
		end
	end

	if matched then
		tx_in.push({ :previous_output => { :hash => tx[:hash], :index => matched },
			     :signature_script => '',
			     :sequence => ((1 << 32) - 1),

			     :pk_script => pk_script })
	end
end




payback = total_takagotch - amount - transaction_fee

raise "" unless payback >= 0

prefix = ['76a914'].pack('H*') 
postfix = ['88ac'].pack('H*')

tx_out = [{ :value => amount, :pk_script => (prefix + to_addr_decoded[:data] + postfix) },
	  { :value => payback, :pk_script => (prefix + public_key_hash + postfix) }]

@created_transaction = {
	:command => :tx,

	:version => 1,
	:tx_in => tx_in,
	:tx_out => tx_out,
	:lock_time => 0
}


signatures = []

tx_in.each_with_index do |tx_in_elm, i|
	duplicated = @created_transaction.dup
	duplicated[:tx_in] = duplicated[:tx_in].dup
	duplicated[:tx_in][i] = duplicated[:tx_in][i].dup


duplicated[:tx_in][i][:signature_script] = tx_in_elm[:pk_script]

serialize_message(duplicated)


verified_str = Key.hash256(@payload + [1].pack('V'))

signatures.push from_key.sign(verified_str)


signatures.each_with_index do |signature, i|
	@created_transaction[:tx_in][i][:signature_script] =
		[signature.length + 1].pack('C') + signature + [1].pack('C') +
		[from_key.to_public_key.length].pack('C') + from_key.to_public_key
end

@status = ''
return

end



