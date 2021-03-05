class CountryController < AppController
  get '/countries' do
    @countries = Country.all
    erb :'countries/index'
  end

  get '/countries/country' do
    country = Country.find_by(name: params[:name])
    redirect "/countries/#{country.id}"
  end

  get '/countries/:id' do
    @country = Country.find_by(id: params[:id])
    @posts = Post.select {|post| post.country == @country}.sort_by {|post| post.created_at}.reverse
    erb :'/countries/show'
  end
end