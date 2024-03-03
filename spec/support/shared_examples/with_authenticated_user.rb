# frozen_string_literal: true

RSpec.shared_context :with_authenticated_user do
  security [Bearer: []]

  let(:user) { create(:user) }
  let!(:Authorization) { JsonWebToken.encode({ user_id: user.id }) }
end
