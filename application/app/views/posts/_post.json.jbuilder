json.extract! post, :id, :topic, :username, :content, :view, :date, :commentCount, :title, :created_at, :updated_at
json.url post_url(post, format: :json)
