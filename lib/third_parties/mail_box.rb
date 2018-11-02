require 'rest-client'
module ThirdParties
  module MailBox
    BASE_URL = 'http://apilayer.net/api/check'.freeze
    OPTIONAL_PARAMS = {access_key: Rails.env == 'development' ? Rails.application.credentials.MAIL_BOX_ACCESS_KEY : ENV['MAIL_BOX_ACCESS_KEY'], stmp: 1, format: 1, callback: nil, email: nil}
    private

    def check(optional_params)
      RestClient.get("#{BASE_URL}?#{format_optional_params(optional_params)}")
    end

    def format_optional_params(optional_params)
      OPTIONAL_PARAMS.merge!(optional_params)
      OPTIONAL_PARAMS.map{|key, value| "#{key}=#{value}" unless value.nil? }.compact.join('&')
    end
  end
end
