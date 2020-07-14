require 'rails_helper'

# Test suite for the Item model
RSpec.describe Item, type: :model do
  it { is_expected.to have_timestamps.for(:creating) }
  it { is_expected.to have_timestamps.for(:updating) }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:status).of_type(String) }
  it { is_expected.to have_field(:deleted).of_type(Mongoid::Boolean)
                          .with_default_value_of(false) }
  it { is_expected.to have_and_belong_to_many(:tags) }
  it { is_expected.to validate_presence_of(:name) }
end
