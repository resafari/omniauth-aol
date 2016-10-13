require 'omniauth/strategies/oauth2'
require 'uri'

module OmniAuth
  module Strategies
    class Aol < OmniAuth::Strategies::OAuth2
      option :name, 'aol'

      option :client_options, {
        :site => 'https://api.screenname.aol.com',
        :authorize_url => 'https://api.screenname.aol.com/auth/authorize',
        :token_url => 'https://api.screenname.aol.com/auth/access_token',
      }

#       uid { "placeholder" }

#       info do
#         {
#             :email => "placeholder"
#         }
#       end

#       extra do
#         {
#             'raw_info' => raw_info
#         }
#       end

      def build_access_token
        verifier = request.params['code']
        redirect_uri = URI.parse(callback_url).tap { |uri| uri.query = nil }.to_s
        client.auth_code.get_token(verifier, {:redirect_uri => redirect_uri}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end
      
#       def raw_info
#         @raw_info ||= Hash.new
#       end
    end
  end
end
