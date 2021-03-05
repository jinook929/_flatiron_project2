class CommentController < AppController
  post '/posts/:post_id/comments' do
    if logged_in?
      Comment.create(params[:comment])
    end
    redirect "/posts/#{params[:post_id]}"
  end

  get '/posts/:post_id/comments/:id/edit' do
    if admin? || current_user == Comment.find_by_id(params[:id]).commenter
      @post = Post.find_by_id(params[:post_id])
      @comments = @post.comments.reverse
      @comment_id_check = params[:id].to_i
      # erb :'comments/edit'
      erb :"posts/show" do
        erb :'comments/edit'
      end
    else
      redirect "/posts/#{params[:post_id]}"
    end
  end

  patch '/posts/:post_id/comments/:id' do
    if admin? || current_user == Comment.find_by_id(params[:id]).commenter
      params.delete("_method")
      Comment.update(params[:id], params[:comment])
    end
    redirect "/posts/#{params[:post_id]}"
  end

  delete '/posts/:post_id/comments/:id' do
    if super? || current_user == Comment.find_by_id(params[:id]).commenter
      Comment.find_by_id(params[:id]).destroy
    end
    redirect "/posts/#{params[:post_id]}"
  end
end