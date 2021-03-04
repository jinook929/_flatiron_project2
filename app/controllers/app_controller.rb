class AppController < Sinatra::Base
  set :public_folder, "./public/"
  set :views, "./app/views/"
  enable :sessions
  set :session_secret, "secret"

  get '/' do
    if Country.all.empty?
      Country.get_countries
    end
    erb :main
  end

  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end # => returns User object

    def logged_in?
      !!current_user
    end # => returns true/false on login status

    def owner?(post_owner) # <= User object
      current_user == post_owner
    end # => returns true/false on ownership

    def admin?
      logged_in? && current_user.admin
    end # => returns true/false on admin status

    def super?
      logged_in? && current_user.super
    end # => returns true/false on admin status

    def video_id(url)
      url.scan(/\?v=(.{11})|youtu.be\/(.{11})/)[0].find {|e| not e.nil?}
    end
  end
end