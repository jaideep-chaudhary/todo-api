collection @items
attributes :_id, :name, :status, :deleted, :created_at, :updated_at

child :tags do
attributes :_id, :title
end