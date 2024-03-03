# frozen_string_literal: true

def convert_params(params, config)
  cfg = config || {}
  params.deep_merge(cfg[:with] || {}).tap do |p|
    without = cfg[:without]
    if without.is_a? Array
      without.each do |elem|
        p.delete(elem)
      end
    end
    p.delete(without)
  end
end

RSpec.shared_examples :valid_form do |config|
  let(:config) { config }
  let(:default_params) { convert_params(params, config) }
  let(:validation_result) { described_class.new.(default_params) }
  it 'should get true' do
    expect(validation_result.success?).to eq true
  end
end

RSpec.shared_examples :invalid_form do |config|
  let(:config) { config }
  let(:default_params) { convert_params(params, config) }
  let(:validation_result) { described_class.new.(default_params) }
  it 'should get false' do
    expect(validation_result.success?).to eq false
  end
end
