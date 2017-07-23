# frozen_string_literal: true

shared_context 'logged in user' do
  let(:user) { create(:user) }
  before { allow_any_instance_of(DecodeAuthenticationCommand).to receive(:result).and_return(user) }
end

shared_context 'logged in admin' do
  let(:user) { create(:user, :admin) }
  before { allow_any_instance_of(DecodeAuthenticationCommand).to receive(:result).and_return(user) }
end
