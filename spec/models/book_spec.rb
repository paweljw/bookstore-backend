# frozen_string_literal: true

describe Book do
  it { is_expected.to belong_to(:author) }

  it { is_expected.to validate_uniqueness_of(:title) }
  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:author_id).of_type(:integer) }
  it { is_expected.to have_db_column(:price_cents).of_type(:integer) }

  describe '#to_s' do
    subject { create(:book) }

    it { expect(subject.to_s).to eq subject.title }
  end
end
