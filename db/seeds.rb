@author = Author.create(username: "admin", email: "admin@gmail.com", password: "P@ssword1", admin: true)
puts "#{Author.count} authors created."

category1 = Category.create(name: "Fiction")
category2 = Category.create(name: "Programming")
puts "#{Category.count} categories created."

article1 = Article.create(title: "Test Article", body: "This is my first test article from seed file",
           author_id: @author.id, category_id: category1.id, published: true) #,
           # image_file_name: nil, image_content_type: nil, image_file_size: nil, image_updated_at: nil>
puts "#{Article.count} articles created."

comment1 = Comment.create(commenter: "James Pradhanan", content: "Nice article", article_id: article1.id)
comment2 = Comment.create(commenter: "Ram Dass", content: "I really love this article", article_id: article1.id)
puts "#{Comment.count} comments created."
