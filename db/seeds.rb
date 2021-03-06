# countries will be set when the server is requested at root for the first time.

# in app, first registered user will be super & admin
User.create(username: "super", email: "super@users.com", password: "123", super: true, admin: true) # super & admin
User.create(username: "admin", email: "admin@users.com", password: "123", admin: true) # not super, just admin
User.create(username: "user", email: "user@users.com", password: "123") # normal user

Post.create(title: "Post_01", youtube: "https://youtu.be/3P1CnWI62Ik", content: "01_This is the Content of the post on Seoul, South Korea.", country_id: 117, user_id: 1)
Post.create(title: "Post_02", youtube: "https://youtu.be/JCYJj3t9RuU", content: "02_This is the Content of the post on New York, United States.", user_id: 2, country_id: 230)
Post.create(title: "Post_03", youtube: "https://youtu.be/6aDFBeWqkMk", content: "03_This is the Content of the post on Ilsan, South Korea.", country_id: 117, user_id: 3)
Post.create(title: "Post_04", youtube: "https://youtu.be/BF55_ykAAYw", content: "04_This is the Content of the post on Dallas, United States.", country_id: 230, user_id: 1)
Post.create(title: "Post_05", youtube: "https://youtu.be/yTK16LC6WXE", content: "05_This is the Content of the post on Little Rock, United States.", country_id: 230, user_id: 2)

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
