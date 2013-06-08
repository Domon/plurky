require 'spec_helper'

describe Plurky::Client do
  let(:configuration) do
    {
      :consumer_key       => 'CK',
      :consumer_secret    => 'CS',
      :oauth_token        => 'OT',
      :oauth_token_secret => 'OTS'
    }
  end

  subject(:client) { Plurky::Client.new(configuration) }

  context "with module configuration" do
    before do
      Plurky.configure do |config|
        configuration.each do |key, value|
          config.send("#{key}=", value)
        end
      end
    end

    after do
      Plurky.reset!
    end

    it "inherits the module configuration" do
      cached_client = Plurky.client
      configuration.each do |key, value|
        expect(cached_client.instance_variable_get(:"@#{key}")).to eq value
      end
    end

    context "with class configuration" do

      let(:different_configuration) { configuration.update :oauth_token_secret => 'OS' }

      it "overrides the module configuration" do
        different_client = Plurky::Client.new(different_configuration)
        different_configuration.each do |key, value|
          expect(different_client.instance_variable_get(:"@#{key}")).to eq value
        end
      end

    end
  end

  describe "#credentials?" do
    it "returns true if all credentials are present" do
      client_with_all_credentials = Plurky::Client.new(configuration)
      expect(client_with_all_credentials.credentials?).to be_true
    end
    it "returns false if any credentials are missing" do
      client_with_missing_credentials =
        Plurky::Client.new(:consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT')
      expect(client_with_missing_credentials.credentials?).to be_false
    end
  end

  describe "#get" do
    let(:path) { '/APP/Profile/getPublicProfile' }
    let(:params) { { :user => 34 } }

    it "knows how to make get request" do
      expect(client).to receive(:request).with(:get, path, params)
      client.get path, params
    end
  end

  describe "#post" do
    let(:path) { '/APP/Timeline/uploadPicture' }
    let(:params) { { :image => "" } }

    it "knows how to make post request" do
      expect(client).to receive(:request).with(:post, path, params)
      client.post path, params
    end
  end

  describe "#connection" do
    it "looks like Faraday connection" do
      expect(client.send(:connection)).to respond_to(:run_request)
    end
  end

  describe "#request" do
  end

  describe "#auth_header" do
    it "creates the correct auth headers" do
      uri = URI("http://www.plurk.com/APP/Profile/getPublicProfile")
      authorization = client.send(:auth_header, :get, uri, { :user_id => 34 })
      expect(authorization.options[:signature_method]).to eq "HMAC-SHA1"
      expect(authorization.options[:version]).to          eq "1.0"
      expect(authorization.options[:consumer_key]).to     eq "CK"
      expect(authorization.options[:consumer_secret]).to  eq "CS"
      expect(authorization.options[:token]).to            eq "OT"
      expect(authorization.options[:token_secret]).to     eq "OTS"
    end
  end

end
