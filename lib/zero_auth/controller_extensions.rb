module ZeroAuth::ControllerExtensions

  def self.included(base)
    base.class_eval do
      extend ClassMethods

      helper_method :current_user

      before_filter :login_required
    end
  end

  protected
  # before_filter :login_required
  def login_required
    session[:return_to] = (request.request_uri == '/logout' ?  nil : request.request_uri)
    access_denied if current_user.anonymous?
  end

  def current_user
    @current_user ||= (login_from_session || login_from_basic_auth || login_by_token || anonymous)
  end

  # авторизация из сессионных кук
  def login_from_session
    if session[:user_id]
      logger.info "Login_from_session #{session[:user_id]}"
      User.active.find_by_id(session[:user_id])
    end
  end

  # авторизация по логину и паролю
  def login_from_basic_auth
    if params[:user]
      login, password = params[:user][:login], params[:user][:password]
      logger.info "Login_from_basic_auth #{login}"
      User.authenticate_by_login(login, password) if login && password
    end
  end

  # авторизация по ключу (после регистрации или смене пароля)
  def login_by_token
    if params[:key]
      User.authenticate_by_token(params[:key])
    end
  end

  def access_denied
    flash[:notice] = "Для доступа к этой части сайта требуется авторизация."

    redirect_to login_path
  end

  def redirect_back_or_default(default)
    redirect_to(params[:return_to] || session[:return_to] || default)
    session[:return_to] = nil
  end

  def action_path
    "#{params[:controller]}/#{params[:action]}"
  end

  def anonymous
    AnonymousUser
  end


  module ClassMethods
    def free_actions(*actions)
      skip_before_filter :login_required, :only => actions
    end
  end
end
