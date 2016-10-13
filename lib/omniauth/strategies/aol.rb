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

      uid { "placeholder" }
#       uid{ raw_info['response']['data']['userData']['loginId'] }

      info do
        {
            :email => "placeholder"
        }
      end

#       info do
#         {
#             :email => raw_info['response']['data']['userData']['attributes']['email'],
#             :display_name => raw_info['response']['data']['userData']['displayName'],
#             :login_id => raw_info['response']['data']['userData']['loginId'],
#             :last_auth => raw_info['response']['data']['userData']['lastAuth']
#         }
#       end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def build_access_token
        puts "-"*100
        verifier = request.params['code']
        redirect_uri = URI.parse(callback_url).tap { |uri| uri.query = nil }.to_s
        client.auth_code.get_token(verifier, {:redirect_uri => redirect_uri}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end
      
      def raw_info
        @raw_info ||= Hash.new
#         @raw_info ||= access_token.get('/auth/getUserDataInternal?attribute=email&f=json').parsed
      end
    end
  end
end
