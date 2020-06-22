class Tag
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :title, type: String
  # model association
  has_and_belongs_to_many :items
  # validations
  validates_presence_of :title
  # class methods
  def self.tag_through_title(title)
    tag = where(title: title).first
    tag.items unless tag.to_a.blank?
  end
end
