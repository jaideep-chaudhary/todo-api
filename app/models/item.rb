class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :name, type: String
  field :status, type: String
  field :deleted, type: Boolean, default: false
  # model association
  has_and_belongs_to_many :tags
  # validation
  validates_presence_of :name
  # scopes
  scope :get_item, -> { where(deleted: false) }
  # class methods
  def self.items_through_tags(title)
    Tag.tag_through_title(title)
  end
end
