require 'spec_helper'

describe Stormpath::Resource::AccountLink, :vcr do
  let(:application) do
    test_api_client.applications.create(name: 'ruby sdk app', description: 'ruby sdk desc')
  end
  let(:directory1) do
    test_api_client.directories.create(name: 'ruby sdk dir 1')
  end
  let(:directory2) do
    test_api_client.directories.create(name: 'ruby sdk dir 2')
  end

  before do
    test_api_client.account_store_mappings.create(
      application: application,
      account_store: directory1,
      list_index: 1,
      is_default_account_store: true,
      is_default_group_store: false
    )

    test_api_client.account_store_mappings.create(
      application: application,
      account_store: directory2,
      list_index: 2,
      is_default_account_store: false,
      is_default_group_store: false
    )
  end

  let!(:account1) do
    directory1.accounts.create(build_account(email: 'jekyll@example.com', username: 'account1'))
  end
  let!(:account2) do
    directory2.accounts.create(build_account(email: 'hyde@example.com', username: 'account2'))
  end

  let!(:account_link) do
    test_api_client.account_links.create(
      left_account: {
        href: account1.href
      },
      right_account: {
        href: account2.href
      }
    )
  end

  after do
    application.delete
    directory1.delete
    directory2.delete
  end

  describe 'instances should respond to attribute property methods' do
    it do
      [:left_account, :right_account].each do |property_accessor|
        expect(account_link).to respond_to(property_accessor)
        expect(account_link).to respond_to("#{property_accessor}=")
        expect(account_link.send(property_accessor)).to be_a Stormpath::Resource::Account
      end

      [:created_at, :modified_at].each do |property_getter|
        expect(account_link).to respond_to(property_getter)
        expect(account_link.send(property_getter)).to be_a String
      end

      expect(account_link.left_account).to be_a Stormpath::Resource::Account
      expect(account_link.right_account).to be_a Stormpath::Resource::Account
    end
  end

  describe 'account link associations' do
    it 'should belong_to right account' do
      expect(account_link.right_account).to eq(account2)
    end

    it 'should belong_to left account' do
      expect(account_link.left_account).to eq(account1)
    end
  end
end