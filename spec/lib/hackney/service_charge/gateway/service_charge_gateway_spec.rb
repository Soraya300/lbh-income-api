require 'rails_helper'

describe Hackney::ServiceCharge::Gateway::ServiceChargeGateway do
  include CaseHelper
  include RequestStubHelper

  let(:gateway) { described_class.new(host: 'https://example.com', key: 'skeleton') }
  let(:refs) { [456] }
  let(:test_url) { 'https://example.com/api/v1/cases?tenancy_refs=%5B456%5D' }

  context 'when retrieving service charge cases' do
    subject { gateway.get_cases_by_refs(refs) }

    context 'with a different host' do
      let(:gateway) { described_class.new(host: 'https://other.com', key: 'skeleton') }
      let(:refs) { [123] }
      let(:test_url) { 'https://other.com/api/v1/cases?tenancy_refs=%5B123%5D' }

      before do
        request_stub(
          url: test_url,
          response_body: { 'cases' => [example_case] }.to_json
        )
      end

      it 'uses the host' do
        subject
        expect(WebMock).to have_requested(:get, test_url).once
      end
    end

    context 'when passing no case refs' do
      let(:refs) { [] }

      it 'gives no cases' do
        expect(subject).to be_empty
      end
    end

    context 'when the case has a ref and uk correspondence address' do
      before do
        request_stub(
          url: test_url,
          response_body: { 'cases' => [
            example_case(correspondence_postcode: 'GY1 2JS')
          ] }.to_json
        )
      end

      it 'recognises international correspondence address' do
        expect(subject.first[:international]).to eq(false)
      end
    end

    context 'when the case has a ref and international correspondence address' do
      before do
        request_stub(
          url: test_url,
          response_body: { 'cases' => [
            example_case(correspondence_postcode: '123123')
          ] }.to_json
        )
      end

      it 'recognises international correspondence address' do
        expect(subject.first[:international]).to eq(true)
      end
    end
  end
end
