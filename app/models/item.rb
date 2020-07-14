class Item
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :name, type: String
  field :status, type: String
  # model association
  has_and_belongs_to_many :tags
  # validation
  validates_presence_of :name
  # callbacks
  before_save :check_status_value
  # scopes
  scope :get_item, -> { where(deleted_at: nil) }
  # class methods
  def self.items_through_tags(title)
    Tag.where(title: title).map(&:items).flatten
  end

  def check_status_value
    self.status = '' unless status.present? && %w[start in-progress completed].include?(status)
  end
end
