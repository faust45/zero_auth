module ZeroAuth

  def self.rand_hash
    ActiveSupport::SecureRandom.hex(32)
  end

  def self.crypt(str)
    Digest::SHA1.hexdigest("scalingh--#{str}--")[0..39]
  end

end

