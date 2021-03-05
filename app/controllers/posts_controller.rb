require 'rack-flash'

class PostController < AppController
  use Rack::Flash

  get '/posts' do
    if not logged_in?
      flash[:message] = "You have to log in first."
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
      flash[:message] = "You have to log in first."
      redirect "/login"
    else
      @countries = Country.all
      erb :'posts/new'
    end
  end

  post '/posts' do
    if not logged_in?
      flash[:message] = "You have to log in first."
      redirect "/login"
    else
      params[:user_id] = current_user.id
      if params[:youtube].include?("youtu") && Post.create(params).id
        flash[:message] = "Vlog successfully created."
        redirect "/posts/#{Post.last.id}"
      else
        flash[:message] = "Fill in the boxes. [ especially <strong>Youtube Address</strong> ]"
        redirect "/posts/new"
      end
    end
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @comments = @post.comments.reverse
    # erb :'posts/show'
    erb :"posts/show" do 
      erb :"comments/index"
    end
  end

  get '/posts/:id/edit' do
    if owner?(Post.find_by_id(params[:id]).user) || admin?
      @post = Post.find_by_id(params[:id])
      @countries = Country.all
      erb :'posts/edit'
    else
      flash[:message] = "Only the owner can edit this vlog."
      redirect "/posts/#{params[:id]}"
    end
  end

  patch '/posts/:id' do
    user = Post.find_by_id(params[:id]).user
    if owner?(user) || admin?
      params.delete("_method")
      params[:user_id] = user.id
      @post = Post.update(params[:id], params)
      if @post
        flash[:message] = "Vlog successfully edited."
        redirect "/posts/#{@post.id}"
      else
        flash[:message] = "Editing failed..."
        redirect "/posts/new"
      end
    else
      flash[:message] = "Only the owner can edit this vlog."
      redirect "/posts/#{params[:id]}"
    end
  end

  delete '/posts/:id' do
    if owner?(Post.find_by_id(params[:id]).user) || super?
      Post.find_by_id(params[:id]).destroy
      flash[:message] = "Vlog successfully deleted."
      redirect "/posts"
    else
      flash[:message] = "Only the owner can delete this vlog."
      redirect "/posts/#{params[:id]}"
    end
  end
end