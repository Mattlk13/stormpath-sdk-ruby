module Stormpath
  module Oauth
    class VerifyTokenResult < Stormpath::Resource::Base
      prop_reader :href, :jwt, :expanded_jwt

      belongs_to :account
      belongs_to :application
      belongs_to :tenant
    end
  end
end
