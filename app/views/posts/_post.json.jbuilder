json.extract! post, :id, :titulo, :contenido, :extension, :usuario_id, :created_at, :updated_at
json.url post_url(post, format: :json)
