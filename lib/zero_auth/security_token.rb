class ZeroAuth::SecurityToken

  LIFETIME = 30.days

  attr_reader :expiry

  def initialize(token = nil, expiry = nil)
    @token  = token  || ZeroAuth.rand_hash
    @expiry = expiry || Time.now + LIFETIME
  end

  def expired?
    @expiry < Time.now 
  end

  def to_s
    @token
  end

end
