module AuthenticationHelpers
  def authenticate(user)
    post '/sessions', params: { email: user.email, password: user.password }
    JSON.parse(response.body)
  end
end
