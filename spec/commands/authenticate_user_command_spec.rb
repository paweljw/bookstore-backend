# frozen_string_literal: true

require 'rails_helper'

describe AuthenticateUserCommand do
  include ActiveSupport::Testing::TimeHelpers

  let!(:user) { create(:user, id: 1) }

  context 'with right user and password' do
    before { travel_to Time.zone.local(2017, 1, 1, 0, 0, 1, 1) }
    after { travel_back }

    let(:expected_token) do
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODMzMTUyMDF9.' \
      '4Ix2FfiY0_Jsjk13mHntg62aVX9BmMgFEembjN2E-Zw'
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
