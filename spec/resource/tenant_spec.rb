require 'spec_helper'

describe Stormpath::Resource::Tenant, :vcr do
  describe 'instances should respond to attribute property methods' do
    let(:tenant) { test_api_client.tenant }

    it do
      expect(tenant).to be_a Stormpath::Resource::Tenant

      [:name, :key, :created_at, :modified_at].each do |property_getter|
        expect(tenant).to respond_to(property_getter)
        expect(tenant.send(property_getter)).to be_a String
      end

      expect(tenant.applications).to be_a Stormpath::Resource::Collection
      expect(tenant.directories).to be_a Stormpath::Resource::Collection
      expect(tenant.organizations).to be_a Stormpath::Resource::Collection
      expect(tenant.custom_data).to be_a Stormpath::Resource::CustomData
    end
  end

  describe '#create_tenant_with_custom_data' do
    let(:tenant) { test_api_client.tenant }

    it 'creates an tenant with custom data' do
      tenant.custom_data['category'] = 'classified'

      tenant.save
      expect(tenant.custom_data['category']).to eq('classified')
    end
  end
end
