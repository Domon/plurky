require 'spec_helper'

describe Plurky do

  describe ".client" do
    it "returns a Plurky::Client" do
      Plurky.client.should be_a Plurky::Client
    end

    context "when the options don't change" do
      it "caches the client" do
        Plurky.client.should == Plurky.client
      end
    end

    context "when the options change" do
      it "creates a new client" do
        client1 = Plurky.client
        Plurky.configure do |config|
          config.consumer_key    = 'CK'
          config.consumer_secret = 'CS'
        end
        client2 = Plurky.client
        client1.should_not == client2
      end
    end
  end

  describe ".respond_to?" do
    it "delegates to Plurky::Client" do
      Plurky.should respond_to :get
    end
  end

end
