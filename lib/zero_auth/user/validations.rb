module ZeroAuth::User::Validations

  def self.included(base)
    base.class_eval do
      validates_presence_of :login,
        :message => 'пустой логин (минимум 3 символа)'

      validates_format_of :login,
        :if => :login?,
        :with => /^[-0-9a-z\._@]+$/i,
        :message => 'логин должен состоять из латинских букв, допустимы цифры и знаки .-_'

      validates_length_of :login,
        :unless => 'errors.on(:login)',
        :within => 3..30,
        :too_short => 'слишком короткий логин (минимум {{count}} символа)',
        :too_long => 'слишком длинный логин (максимум {{count}} символов)'

      validates_uniqueness_of :login,
        :unless => 'errors.on(:login)',
        :case_sensitive => false,
        :message => 'пользователь с таким логином уже существует'


      validates_presence_of :password,
        :message => 'пустой пароль (минимум 6 символов)'

      validates_length_of :password,
        :if => :password?,
        :within => 6..40,
        :too_short => 'слишком короткий пароль (минимум {{count}} символов)',
        :too_long => 'слишком длинный пароль (максимум {{count}} символов)'

      validates_presence_of :password_confirmation,
        :unless => 'errors.on(:password)',
        :message => 'пустое поле подтверждения пароля'

      validates_confirmation_of :password,
        :unless => 'password_confirmation.blank? or errors.on(:password)',
        :message => 'введенные пароли не совпадают'
    end
  end

end
