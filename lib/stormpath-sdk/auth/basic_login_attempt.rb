#
# Copyright 2012 Stormpath, Inc.
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
  module Authentication
    class BasicLoginAttempt < Stormpath::Resource::Base
      TYPE = 'type'.freeze
      VALUE = 'value'.freeze
      ACCOUNT_STORE = 'account_store'.freeze

      def account_store
        get_property ACCOUNT_STORE
      end

      def account_store=(account_store)
        if account_store.is_a? Stormpath::Resource::Base
          set_property ACCOUNT_STORE, HREF_PROP_NAME => account_store.href
        elsif account_store.is_a? Hash
          set_property ACCOUNT_STORE, sanitize(account_store)
        else
          raise ArgumentError, 'account_store should be a Stormpath::Resource::Instance or a Hash'
        end
      end

      def type
        get_property TYPE
      end

      def type=(type)
        set_property TYPE, type
      end

      def value
        get_property VALUE
      end

      def value=(value)
        set_property VALUE, value
      end
    end
  end
end
