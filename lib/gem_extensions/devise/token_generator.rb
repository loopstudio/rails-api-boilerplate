module GemExtensions
  module Devise
    module TokenGenerator
      SHORT_TOKEN_COLUMNS = [:reset_password_token].freeze

      def generate(klass, column)
        key = key_for(column)

        loop do
          raw = short_token?(column) ? short_raw_token : long_raw_token
          enc = OpenSSL::HMAC.hexdigest(@digest, key, raw)
          break [raw, enc] unless klass.to_adapter.find_first(column => enc)
        end
      end

      private

      def short_token?(column)
        SHORT_TOKEN_COLUMNS.include?(column)
      end

      def short_raw_token
        rand(100_000..999_999).to_s
      end

      def long_raw_token
        Devise.friendly_token
      end
    end
  end
end
