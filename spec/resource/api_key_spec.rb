require 'spec_helper'

describe Stormpath::Resource::ApiKey, :vcr do
  let(:application) { test_application }
  let(:tenant) { application.tenant }

  let(:account) do
    application.accounts.create(
      email: 'test@example.com',
      given_name: 'Ruby SDK',
      password: 'P@$$w0rd',
      surname: 'SDK'
    )
  end

  let(:api_key) { account.api_keys.create({}) }

  after { account.delete }

  describe "instances should respond to attribute property methods" do
    it do
      [:name, :description, :status].each do |property_accessor|
        expect(api_key).to respond_to(property_accessor)
        expect(api_key).to respond_to("#{property_accessor}=")
      end

      [:id, :secret].each do |property_getter|
        expect(api_key).to respond_to(property_getter)
        expect(api_key.send property_getter).to be_a String
      end

      expect(api_key.tenant).to be_a Stormpath::Resource::Tenant
      expect(api_key.account).to be_a Stormpath::Resource::Account
    end
  end

  describe 'api_key_associations' do
    it 'should belong_to account' do
      expect(api_key.account).to eq(account)
    end

    it 'should belong_to tenant' do
      expect(api_key.tenant).to eq(tenant)
    end

    it 'apps can fetch api keys' do
      fetched_api_key = application.api_keys.search(id: api_key.id).first
      expect(fetched_api_key).to eq(api_key)
    end
  end
end
