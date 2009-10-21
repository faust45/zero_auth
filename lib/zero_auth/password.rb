class ZeroAuth::Password

  attr_reader :password, :salt
  delegate :blank?, :nil?, :length, :size, 
    :to => :password

  def initialize(password, salt = nil)
    @password = password
    @salt = salt || ZeroAuth.rand_hash
  end

  def ==(other_password)
    @password == other_password
  end

  def crypt_password
    unless @password.blank?
      @crypt_password ||= ZeroAuth.crypt(@salt + ZeroAuth.crypt(@password))
    end
  end

  def raw
    @password
  end

end
