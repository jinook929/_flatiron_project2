class AppController < Sinatra::Base
  set :public_folder, "./public/"
  set :views, "./app/views/"
  enable :sessions
  set :session_secret, "secret"

  get '/' do
    erb :home
  end
end