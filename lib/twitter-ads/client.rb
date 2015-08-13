# Copyright (C) 2015 Twitter, Inc.

module TwitterAds

  # The Ads API Client class which functions as a
  # container for basic API consumer information.
  class Client
    attr_accessor :consumer_key,
                  :consumer_secret,
                  :access_token,
                  :access_token_secret

    # Creates a new Ads API client instance.
    #
    # @param consumer_key nil [String] The application consumer key value.
    # @param consumer_secret nil [String] The application consumer secret value.
    # @param access_token nil [String] The access token value.
    # @param access_token_secret nil [String] The access token secret value.
    #
    # @since 0.1.0
    #
    # @return [Client] The newly created client instance.
    def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
      @consumer_key        = consumer_key
      @consumer_secret     = consumer_secret
      @access_token        = access_token
      @access_token_secret = access_token_secret
      validate
      self
    end

    # Returns an inspection string for the current Client instance.
    #
    # @example
    #   client.inspect
    #
    # @since 0.1.0
    #
    # @return [String] The inspection string.
    def inspect
      "#<#{self.class.name}:0x#{object_id} consumer_key=\"#{@consumer_key}\">"
    end

    # Returns a collection of advertiser Accounts avaiable to the current access token.
    #
    # @example
    #   client.accounts
    #   client.accounts('3ofs6l')
    #   client.accounts('3ofs6l', with_deleted: true)
    #
    # @param id=nil [String] The account ID string.
    # @param opts={} [Hash] Hash of optional values.
    #
    # @option opts [String] :with_deleted Indicates whether or not to included deleted objects.
    #
    # @since 0.1.0
    #
    # @return [Account] The instance of the Account object.
    def accounts(id = nil, opts = {})
      id ? Account.load(self, id) : Account.all(self, opts)
    end

    private

    def validate
      [:consumer_key, :consumer_secret, :access_token, :access_token_secret].each do |name|
        fail(ArgumentError, "Error! Missing required #{name}.") unless send(name)
      end
    end
  end

end
