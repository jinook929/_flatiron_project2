require 'rack-flash'

class PostController < AppController
  use Rack::Flash

  get '/posts' do
    if not logged_in?
      redirect "login"
    else
      @posts = Post.all.sort_by {|post| post.created_at}.reverse
      erb :'posts/index'
    end
  end

  get '/posts/search' do
    keyword = params[:q]
    @results = Post.all.select {|post|
      post.title.downcase.include?(keyword) || post.content.downcase.include?(keyword)
    }.reverse
    erb :'posts/search'
  end

  get '/posts/new' do
    if not logged_in?
      redirect "/login"
    else
      @countries = Country.all
      erb :'posts/new'
    end
  end

  post '/posts' do
    if not logged_in?
      redirect "/login"
    else
      params[:user_id] = current_user.id
      if params[:youtube].include?("youtu") && Post.create(params).id
        redirect "/posts/#{Post.last.id}"
      else
        flash[:message] = "Fill in the boxes. [ especially <strong>Youtube Address</strong> ]"
        redirect "/posts/new"
      end
    end
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :'posts/show'
  end

  get '/posts/:id/edit' do
    if owner?(Post.find_by_id(params[:id]).user) || admin?
      @post = Post.find_by_id(params[:id])
      @countries = Country.all
      erb :'posts/edit'
    else
      redirect "/login"
    end
  end

  patch '/posts/:id' do
    if owner?(Post.find_by_id(params[:id]).user) || admin?
      params.delete("_method")
      params[:user_id] = params[:id]
      @post = Post.update(params[:id], params)
      if @post
        redirect "/posts/#{@post.id}"
      else
        redirect "/posts/new"
      end
    else
      redirect "/login"
    end
  end

  delete '/posts/:id' do
    if owner?(Post.find_by_id(params[:id]).user) || super?
      Post.find_by_id(params[:id]).destroy
      redirect "/posts"
    else
      redirect "/posts/#{params[:id]}"
    end
  end
end