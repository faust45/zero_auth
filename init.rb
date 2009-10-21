class ActionController::Base

  def self.use_zero_auth
    include ZeroAuth::ControllerExtensions
  end

end

class ActiveRecord::Base

  def self.use_zero_auth
    include ZeroAuth::User::Attributes
    include ZeroAuth::User::Methods
    include ZeroAuth::User::Scopes
    include ZeroAuth::User::Validations
    include ZeroAuth::User::Authentication
  end

end
