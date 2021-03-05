# countries will be set when the server is requested at root for the first time.

User.create(username: "super", email: "super@users.com", password: "123") # first registered user will be super & admin
User.create(username: "admin", email: "admin@users.com", password: "123", admin: ture) # not super, just admin
User.create(username: "user", email: "user@users.com", password: "123") # normal user

Post.create(title: "Post_01", content: "01_This is the Content of the post on Seoul, South Korea.", user_id: 1, country_id: 117)
Post.create(title: "Post_02", content: "02_This is the Content of the post on New York, United States.", user_id: 2, country_id: 230)
Post.create(title: "Post_03", content: "03_This is the Content of the post on Ilsan, South Korea.", user_id: 3, country_id: 117)
Post.create(title: "Post_04", content: "04_This is the Content of the post on Dallas, United States.", user_id: 1, country_id: 230)
Post.create(title: "Post_05", content: "05_This is the Content of the post on Little Rock, United States.", user_id: 2, country_id: 230)

Comment.create(content: "Comment_01", post_id: 1, commenter_id: 2)
Comment.create(content: "Comment_02", post_id: 1, commenter_id: 1)
Comment.create(content: "Comment_03", post_id: 2, commenter_id: 3)
Comment.create(content: "Comment_04", post_id: 2, commenter_id: 2)
Comment.create(content: "Comment_05", post_id: 3, commenter_id: 1)
Comment.create(content: "Comment_06", post_id: 3, commenter_id: 2)
Comment.create(content: "Comment_07", post_id: 4, commenter_id: 3)
Comment.create(content: "Comment_08", post_id: 1, commenter_id: 2)
Comment.create(content: "Comment_09", post_id: 1, commenter_id: 1)
Comment.create(content: "Comment_10", post_id: 5, commenter_id: 1)
