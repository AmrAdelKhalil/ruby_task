module UserServices
  class VerifyUserEmail
    include ThirdParties::MailBox
    attr_reader :optional_params
    def initialize(email, optional_params={})
      @optional_params = optional_params.merge(email: email)
    end
    def call
      check(optional_params)
    end
  end
end
