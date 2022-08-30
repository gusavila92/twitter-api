json.id post.id
json.body post.body
json.created_at post.created_at
json.user do
  json.partial! 'users/user', user: post.user
end