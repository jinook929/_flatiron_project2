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

  get '/users/:id/posts' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user
        @posts = Post.all.select {|post|
          post.user == @user
        }
      else
        redirect "/users/#{@user.id}"
      end
      erb :'users/user_posts'
    else
      redirect "/login"
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

  get '/users/:id/edit' do
    if logged_in? && super?
      @user = User.find_by_id(params[:id])
      erb :'users/edit'
    else
      redirect "/login"
    end
  end

  patch '/users/:id' do
    if logged_in? && super?
      params.delete("_method")
      User.update(params[:id], params)
      redirect "/users/#{params[:id]}"
    else
      redirect "/users"
    end
  end

  delete '/users/:id' do
    if logged_in? && super?
      User.find_by_id(params[:id]).destroy
      redirect "/users"
    else
      redirect "/users/#{params[:id]}"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/posts"
    else
      erb :'users/login'
    end
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
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect "/login"
    end
  end
end