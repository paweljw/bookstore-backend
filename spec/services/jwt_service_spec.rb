# frozen_string_literal: true

require 'rails_helper'

describe JwtService do
  subject { described_class }

  let(:payload) { { 'one' => 'two' } }
  let(:token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJvbmUiOiJ0d28ifQ.VcHxBxg0HvXodGnNJxYvOodEaOTcB3_szy65osW4edw' }

  describe '.encode' do
    it { expect(subject.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    it { expect(subject.decode(token)).to eq(payload) }
  end
end
