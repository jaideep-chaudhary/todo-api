require 'rails_helper'

# Test suite for the Tag model
RSpec.describe Tag, type: :model do
  it { is_expected.to have_timestamps.for(:creating) }
  it { is_expected.to have_timestamps.for(:updating) }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_and_belong_to_many(:items) }
end