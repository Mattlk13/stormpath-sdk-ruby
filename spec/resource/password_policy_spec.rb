require 'spec_helper'

describe Stormpath::Resource::PasswordPolicy, :vcr do
  let(:application) { test_api_client.applications.create(application_attrs) }

  after { application.delete }

  describe 'instances should respond to attribute property methods' do
    let(:directory) { test_api_client.directories.create(directory_attrs) }
    let(:password_policy) { directory.password_policy }

    before do
      map_account_store(application, directory, 1, false, false)
    end

    after { directory.delete }

    it do
      expect(password_policy).to be_a Stormpath::Resource::PasswordPolicy

      [:reset_token_ttl, :reset_email_status, :reset_success_email_status].each do |property_accessor|
        expect(password_policy).to respond_to(property_accessor)
        expect(password_policy).to respond_to("#{property_accessor}=")
      end

      expect(password_policy.strength).to be_a Stormpath::Resource::PasswordStrength
      expect(password_policy.reset_email_templates).to be_a Stormpath::Resource::Collection
      expect(password_policy.reset_success_email_templates).to be_a Stormpath::Resource::Collection

      expect(password_policy.reset_email_templates.first).to be_a Stormpath::Resource::EmailTemplate
      expect(password_policy.reset_success_email_templates.first).to be_a Stormpath::Resource::EmailTemplate
    end

    it 'can change reset_token_ttl' do
      expect(directory.password_policy.reset_token_ttl).to eq(24)
      password_policy.reset_token_ttl = 10
      password_policy.save
      expect(directory.password_policy.reset_token_ttl).to eq(10)
    end

    it 'can change reset_email_status' do
      expect(directory.password_policy.reset_email_status).to eq('ENABLED')
      password_policy.reset_email_status = 'DISABLED'
      password_policy.save
      expect(directory.password_policy.reset_email_status).to eq('DISABLED')
    end

    it 'can change reset_success_email_status' do
      expect(directory.password_policy.reset_success_email_status).to eq('ENABLED')
      password_policy.reset_success_email_status = 'DISABLED'
      password_policy.save
      expect(directory.password_policy.reset_success_email_status).to eq('DISABLED')
    end
  end
end
