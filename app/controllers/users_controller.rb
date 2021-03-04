class UserController < AppController
  get '/users' do
    if admin?
      @users = User.all
      erb :'users/index'
    else
      redirect "/"
    end
  end

  get '/users/:id' do
    if admin? || (logged_in? && current_user.id == params[:id].to_i)
      @user = User.find_by_id(params[:id])
      erb :'users/show'
    else
      redirect "/"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/posts"
    end
    erb :'users/signup'
  end

  post '/signup' do
    if User.all.empty?
      @user = User.create(params)
      @user.admin = true
      @user.super = true
      @user.save
    else
      @user = User.create(params)
    end

    if @user.id
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/posts'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end