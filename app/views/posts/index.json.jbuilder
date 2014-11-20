json.posts @posts do |post|
  json.title post.title
  json.body post.body
end