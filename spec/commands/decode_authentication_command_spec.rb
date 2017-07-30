# frozen_string_literal: true

describe DecodeAuthenticationCommand do
  include ActiveSupport::Testing::TimeHelpers

  context 'without token' do
    subject { described_class.call('') }

    it { expect(subject.success?).to_not be }
    it { expect(subject.errors.keys).to include(:token) }
    it { expect(subject.errors.values.flatten).to include('Token is missing') }
  end

  context 'with expired token' do
    let!(:user) { create(:user, id: 1) }
    let(:expired_header) do
      {
        'Authorization' => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODMzMTUyMDF9.' \
                           '4Ix2FfiY0_Jsjk13mHntg62aVX9BmMgFEembjN2E-Zw'
      }
    end

    subject { described_class.call(expired_header) }

    it { expect(subject.success?).to_not be }
    it { expect(subject.errors.keys).to include(:token) }
    it { expect(subject.errors.values.flatten).to include('Token is expired') }
  end

  context 'with invalid token' do
    before { travel_to Time.zone.local(2017, 1, 1) }
    after { travel_back }

    let(:expired_header) do
      {
        'Authorization' => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODMzMTUyMDF9.' \
                           '4Ix2FfiY0_Jsjk13mHntg62aVX9BmMgFEembjN2E-Zw'
      }
    end

    subject { described_class.call(expired_header) }

    it { expect(subject.success?).to_not be }
    it { expect(subject.errors.keys).to include(:token) }
    it { expect(subject.errors.values.flatten).to include('Token is invalid') }
  end

  context 'with valid token' do
    before { travel_to Time.zone.local(2017, 1, 1) }
    after { travel_back }
    let!(:user) { create(:user, id: 1) }

    let(:expired_header) do
      {
        'Authorization' => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODMzMTUyMDF9.' \
                           '4Ix2FfiY0_Jsjk13mHntg62aVX9BmMgFEembjN2E-Zw'
      }
    end

    subject { described_class.call(expired_header) }

    it { expect(subject.success?).to be }
    it { expect(subject.errors).to be_empty }
  end
end
