class ZeroAuth::CryptPassword
  def initialize(password, salt)
    @crypt_password = password 
    @salt = salt
  end

  def ==(other_password)
    @crypt_password == ZeroAuth::Password.new(other_password, @salt).crypt_password
  end
end
