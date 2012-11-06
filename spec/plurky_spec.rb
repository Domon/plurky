require 'spec_helper'

describe Plurky do

  describe ".client" do
    it "returns a Plurky::Client" do
      Plurky.client.should be_a Plurky::Client
    end
  end

  describe ".respond_to?" do
    it "delegates to Plurky::Client" do
      Plurky.should respond_to :get
    end
  end

end
