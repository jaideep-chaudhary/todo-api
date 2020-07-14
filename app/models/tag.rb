class Tag
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :title, type: String
  # model association
  has_and_belongs_to_many :items
  # validations
  validates_presence_of :title
end
