# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaginateForm do
  let(:params) { { page: 1, limit: 1 } }

  it_behaves_like :valid_form

  it_behaves_like :valid_form, without: %i[page limit]
  it_behaves_like :invalid_form, with: { page: 0 }
  it_behaves_like :invalid_form, with: { page: 'sobaka' }
  it_behaves_like :invalid_form, with: { limit: 0 }
  it_behaves_like :invalid_form, with: { limit: 'sobaka' }
end
