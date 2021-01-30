json.extract! comment, :id, :content, :username, :pID, :cID, :created_at, :updated_at
json.url comment_url(comment, format: :json)
