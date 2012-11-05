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

  subject { Plurky::Client.new(configuration) }

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
      client = Plurky.new
      configuration.each do |key, value|
        client.instance_variable_get(:"@#{key}").should == value
      end
    end

    context "with class configuration" do

      let(:different_configuration) { configuration.update :oauth_token_secret => 'OS' }

      it "overrides the module configuration" do
        client = Plurky::Client.new(different_configuration)
        different_configuration.each do |key, value|
          client.instance_variable_get(:"@#{key}").should == value
        end
      end

    end
  end

  describe "#credentials?" do
    it "returns true if all credentials are present" do
      client = Plurky::Client.new(configuration)
      client.credentials?.should be_true
    end
    it "returns false if any credentials are missing" do
      client = Plurky::Client.new(:consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT')
      client.credentials?.should be_false
    end
  end

  describe "#get" do
    let(:path) { '/APP/Profile/getPublicProfile' }
    let(:params) { { :user => 34 } }

    it "knows how to make get request" do
      subject.should_receive(:request).with(:get, path, params)
      subject.get path, params
    end
  end

  describe "#post" do
    let(:path) { '/APP/Timeline/uploadPicture' }
    let(:params) { { :image => "" } }

    it "knows how to make post request" do
      subject.should_receive(:request).with(:post, path, params)
      subject.post path, params
    end
  end

  describe "#connection" do
    it "looks like Faraday connection" do
      subject.send(:connection).should respond_to(:run_request)
    end
  end

  describe "#request" do
  end

  describe "#auth_header" do
    it "creates the correct auth headers" do
      uri = URI("http://www.plurk.com/APP/Profile/getPublicProfile")
      authorization = subject.send(:auth_header, :get, uri, { :user_id => 34 })
      authorization.options[:signature_method].should == "HMAC-SHA1"
      authorization.options[:version].should          == "1.0"
      authorization.options[:consumer_key].should     == "CK"
      authorization.options[:consumer_secret].should  == "CS"
      authorization.options[:token].should            == "OT"
      authorization.options[:token_secret].should     == "OTS"
    end
  end

end
