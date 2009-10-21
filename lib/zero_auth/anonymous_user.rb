module ZeroAuth::AnonymousUser
  class <<self
    def anonymous?
      true
    end
     
    def logged_in?
      false
    end
  end
end
