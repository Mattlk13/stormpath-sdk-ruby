#
# Copyright 2014 Stormpath, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Stormpath
  module Provider
    class AccountResolver
      include Stormpath::Util::Assert

      def initialize data_store
        @data_store = data_store
      end

      def resolve_provider_account parent_href, request
        assert_not_nil parent_href, "parent_href argument must be specified"
        assert_kind_of AccountRequest, request, "Only #{AccountRequest} instances are supported."

        attempt = @data_store.instantiate AccountAccess

        # TODO: need to add an options hash and pass all attributes from the providers?
        # https://stormpath.atlassian.net/wiki/display/AM/Social+Login+V2/#SocialLoginV2-ClientAPIChanges
        attempt.provider_data = {
                                  request.token_type.to_s.camelize(:lower) => request.token_value,
                                  "providerId" => request.provider
                                }

        href = parent_href + '/accounts'

        @data_store.create href, attempt, Stormpath::Provider::AccountResult
      end

    end
  end
end
