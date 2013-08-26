module AuthMacros
  def sign_out(user = @current_user)
      Capybara.reset_sessions!
  end

  def sign_in(user)
    post user_session_url, :login => user.login, :password => 'password'
  end
end
