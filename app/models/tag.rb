class Tag
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :title, type: String
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title

  # class methods
  def self.tag_through_title(title)
    where(title: title).pluck(:_id) || []
  end
end
