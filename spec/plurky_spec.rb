require 'spec_helper'

describe Plurky do

  describe ".client" do
    it "returns a Plurky::Client" do
      expect(Plurky.client).to be_a Plurky::Client
    end

    context "when the options don't change" do
      it "caches the client" do
        expect(Plurky.client).to eq Plurky.client
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
        expect(client1).not_to eq client2
      end
    end
  end

  describe ".respond_to?" do
    it "delegates to Plurky::Client" do
      expect(Plurky).to respond_to :get
    end
  end

  describe ".configure" do
  end

end
