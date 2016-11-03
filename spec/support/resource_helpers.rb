module Stormpath
  module Test
    module ResourceHelpers
      def build_account(opts = {})
        opts.tap do |o|
          o[:email]      = (!opts[:email].blank? && opts[:email]) || "ruby-test-#{random_number}@testmail.stormpath.com"
          o[:username]   = (!opts[:username].blank? && opts[:username]) || "ruby-test-#{random_number}"
          o[:password]   = (!opts[:password].blank? && opts[:password]) || 'P@$$w0rd'
          o[:surname]    = (!opts[:surname].blank? && opts[:surname]) || 'surname'
          o[:given_name] = (!opts[:given_name].blank? && opts[:given_name]) || 'givenname'
        end
      end

      def build_application(opts = {})
        opts.tap do |o|
          o[:name]          = (!opts[:name].blank? && opts[:name]) || "ruby-test-#{random_number}-app"
          o[:description]   = (!opts[:description].blank? && opts[:description]) || "ruby-test-#{random_number}-desc"
        end
      end

      def build_directory(opts = {})
        opts.tap do |o|
          o[:name]          = (!opts[:name].blank? && opts[:name]) || "ruby-test-#{random_number}-dir"
          o[:description]   = (!opts[:description].blank? && opts[:description]) || "ruby-test-#{random_number}-desc"
        end
      end

      def build_organization(opts = {})
        opts.tap do |o|
          o[:name]      = (!opts[:name].blank? && opts[:name]) || "ruby-test-#{random_number}-org"
          o[:name_key]  = (!opts[:name_key].blank? && opts[:name_key]) || "ruby-test-#{random_number}-org"
        end
      end

      def build_group(opts = {})
        opts.tap do |o|
          o[:name]      = (!opts[:name].blank? && opts[:name]) || "ruby-test-#{random_number}-group"
        end
      end

      def enable_email_verification(directory)
        directory.account_creation_policy.verification_email_status = 'ENABLED'
        directory.account_creation_policy.verification_success_email_status = 'ENABLED'
        directory.account_creation_policy.welcome_email_status = 'ENABLED'
        directory.account_creation_policy.save
      end

      def map_account_store(app, store, index, default_account_store, default_group_store)
        test_api_client.account_store_mappings.create(
          application: app,
          account_store: store,
          list_index: index,
          is_default_account_store: default_account_store,
          is_default_group_store: default_group_store
        )
      end

      def map_organization_store(account_store, organization, default_account_store = false)
        test_api_client.organization_account_store_mappings.create(
          account_store: { href: account_store.href },
          organization: { href: organization.href },
          is_default_account_store: default_account_store
        )
      end

      def random_number
        Random.rand(1..10_000)
      end
    end
  end
end
