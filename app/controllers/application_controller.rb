class ApplicationController < ActionController::API
  def current_user
    # TODO: Replace this with a real authentication system
    # In order to keep this example simple, we're just going to hardcode a
    # single user that will be returned regardless of the request.
    @current_user ||= Account.first
  end
end
