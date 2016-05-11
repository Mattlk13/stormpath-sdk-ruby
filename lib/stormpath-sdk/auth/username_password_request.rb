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
    class UsernamePasswordRequest

      attr_reader :host, :account_store

      def initialize username, password, options = {}
        @username = username
        @password = (password || "").chars.to_a
        @host = options[:host]
        @account_store = options[:account_store]
      end

      def principals
        @username
      end

      def credentials
        @password
      end

      def clear
        @username = nil
        @host = nil
        @account_store = nil

        @password.each { |pass_char| pass_char = 0x00 }
        @password = nil
      end

    end
  end
end
