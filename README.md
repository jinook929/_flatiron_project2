# TraVlog

# 1. $ `bundle init`

# 2. ./`Gemfile`
```ruby
# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
gem 'rake'
gem 'sinatra'
gem 'activerecord', '~> 5.2.4.5', :require => 'active_record'
gem 'sinatra-activerecord'
gem 'sqlite3'
gem 'shotgun'

gem 'require_all'
gem 'pry'
```

# 3. $ `bundle install`

# 4. ./`Rakefile`
```ruby
require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Start Pry console"
task :console do
  Pry.start
end
```

# 5. ./`config.ru`
```ruby
require_relative './config/environment'

use Rack::MethodOverride
# other controllers here
run AppController
```

# 6. folders
```ruby
|- app
|    |- controllers
|    |- models
|    |- views
|- config
|       environment.rb
|- db
|   |- migrate
|   seeds.rb
config.ru
Gemfile
Rakefile
README.md
```

# 7. ./config/`environment.rb`
```ruby
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection ({
  adapter: "sqlite3", 
  database: "db/database.db"
})

require_all 'app'
```
# 8. migration files
```ruby
$ rake db:create_migration NAME=create_users
$ rake db:create_migration NAME=create_posts
$ rake db:create_migration NAME=create_comments
```

# 9. model files: ./app/models/`user.rb` `post.rb` `comment.rb` `country.rb` ...

# 10. $ `rake db:migrate`

# 11. ./db/`seeds.rb`
```ruby
User.create(name: "Person_01", email: "person_01@users.com", password: "123")
User.create(name: "Person_02", email: "person_02@users.com", password: "123")
User.create(name: "Person_03", email: "person_03@users.com", password: "123")

# Country.create(name: "Korea South", url: "http://www.geognos.com/geo/en/cc/kr.html")
# Country.create(name: "United States", url: "http://www.geognos.com/geo/en/cc/us.html")

Post.create(title: "Post_01", content: "01_This is the Content of the post on Seoul, South Korea.", author_id: 1, country_id: 117)
Post.create(title: "Post_02", content: "02_This is the Content of the post on New York, United States.", author_id: 2, country_id: 230)
Post.create(title: "Post_03", content: "03_This is the Content of the post on Ilsan, South Korea.", author_id: 3, country_id: 117)
Post.create(title: "Post_04", content: "04_This is the Content of the post on Dallas, United States.", author_id: 1, country_id: 230)
Post.create(title: "Post_05", content: "05_This is the Content of the post on Little Rock, United States.", author_id: 2, country_id: 230)

Comment.creat(content: "Comment_01", post_id: 1, commenter_id: 2)
Comment.creat(content: "Comment_02", post_id: 1, commenter_id: 1)
Comment.creat(content: "Comment_03", post_id: 2, commenter_id: 3)
Comment.creat(content: "Comment_04", post_id: 2, commenter_id: 2)
Comment.creat(content: "Comment_05", post_id: 3, commenter_id: 1)
Comment.creat(content: "Comment_06", post_id: 3, commenter_id: 2)
Comment.creat(content: "Comment_07", post_id: 4, commenter_id: 3)
Comment.creat(content: "Comment_08", post_id: 1, commenter_id: 2)
Comment.creat(content: "Comment_09", post_id: 1, commenter_id: 1)
Comment.creat(content: "Comment_10", post_id: 5, commenter_id: 1)
```

# 12. $ `rake db:seed`

# 13. $ `shotgun`



```ruby
|- app
|    |- controllers
|    |            app_controller.rb
|    |            user_controller.rb
|    |            post_controller.rb
|    |            comment_controller.rb
|    |- models
|    |       comment.rb
|    |       post.rb
|    |       user.rb
|    |- views
|           |- comments
|           |- posts
|           |- users
|           main.rb
|- config
|       environment.rb
|- db
|   |- migrate
|   seed.rb
config.ru
Gemfile
Rakefile
README.md
```