# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationships::RelationshipForm do
  let(:params) { { followed_id: 2 } }

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :followed_id
  it_behaves_like :invalid_form, with: { followed_id: 0 }
  it_behaves_like :invalid_form, with: { followed_id: 'sobaka' }
end
