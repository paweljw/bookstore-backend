# frozen_string_literal: true

require 'rails_helper'

describe AuthenticateUserCommand do
  let!(:user) { create(:user, id: 1) }

  context 'with right user and password' do
    before { Timecop.freeze(2017, 1, 1, 0, 0, 1, 1) }
    after { Timecop.return }

    let(:expected_token) do
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmF0aW9uIjoxNDgzMzE1MjAxfQ.' \
      'bMict_biZTOT545LKhD_RqnpY9GPmHiagtrR9sFSBPo'
    end

    subject { described_class.call(user.email, 'password123') }

    it { expect(subject.success?).to be }
    it { expect(subject.result).to eq expected_token }
  end

  context 'with right user and wrong password' do
    subject { described_class.call(user.email, 'hackerman123') }

    it { expect(subject.success?).to_not be }
    it { expect(subject.result).to_not be }
  end

  context 'with everything wrong' do
    subject { described_class.call('dhh@rails.local', 'hackerman123') }

    it { expect(subject.success?).to_not be }
    it { expect(subject.result).to_not be }
  end
end
