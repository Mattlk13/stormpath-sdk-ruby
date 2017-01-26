module Stormpath
  module Oauth
    class SocialGrantRequest
      attr_accessor :grant_type, :provider_id, :code, :access_token, :redirect_uri

      def initialize(provider_id, options = {})
        @provider_id = provider_id.to_s
        @code = options[:code]
        @access_token = options[:access_token]
        @redirect_uri = options[:redirect_uri]
        @grant_type = 'stormpath_social'
      end
    end
  end
end
