module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def admin?
    logged_in? && current_user.admin
  end

  def logged_in_admin
    unless logged_in? && current_user.admin?
      flash[:danger] = "Access denied."
      redirect_back(fallback_location: root_path)
    end
  end
end
