# frozen_string_literal: true

require 'rails_helper'

describe Author do
  it { is_expected.to have_many(:books) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_db_column(:name).of_type(:string) }
end
