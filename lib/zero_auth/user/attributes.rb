module ZeroAuth::User::Attributes

  def self.included(base)
    base.class_eval do
      attr_accessible :login, :password, :password_confirmation
      attr_accessor :password_confirmation
    
      composed_of :password, :class_name => 'ZeroAuth::CryptPassword',
        :mapping => [ %w(password crypt_password), %w(salt salt) ],
        :allow_nil   => true,
        :converter   => proc {|pass| ZeroAuth::Password.new(pass) } 

      composed_of :security_token, :class_name => 'ZeroAuth::SecurityToken',
        :mapping => [ %w(security_token to_s), %w(security_token_expiry expiry) ],
        :constructor => :new,
        :converter   => :new

      before_create proc{|u| u.security_token = ZeroAuth::SecurityToken.new }
    end
  end

end
