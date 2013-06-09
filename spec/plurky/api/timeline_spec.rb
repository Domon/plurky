require 'spec_helper'

describe Plurky::API::Timeline do
  subject(:client) { Plurky::Client.new }

  describe "#status" do
    before do
      stub_get("/APP/Timeline/getPlurk", :plurk_id => 1001647781).
        to_return(json_response("status.json"))
    end

    it "requests the correct resource" do
      client.status(1001647781)
      expect(a_get("/APP/Timeline/getPlurk", :plurk_id => 1001647781)).to have_been_made
    end

    it "returns a correct Hashie::Mash" do
      status = client.status(1001647781)
      expect(status).to be_a Hashie::Mash
      expect(status.plurk.content_raw).to eq "http://ridiculousfish.com/shell/index.html (Finally, a command line shell for the 90s) http://emos.plurk.com/b6ebb0a088fa352ee03ed6f760fb319d_w16_h16.png"
    end
  end

  describe "#update" do
    before do
      stub_post("/APP/Timeline/plurkAdd", :content => "I'm plurking with Plurky!", :qualifier => "says").
        to_return(json_response("update.json"))
    end

    it "requests the correct resource" do
      client.update("I'm plurking with Plurky!", "says")
      expect(a_post("/APP/Timeline/plurkAdd", :content => "I'm plurking with Plurky!", :qualifier => "says")).to have_been_made
    end

    it "returns a correct Hashie::Mash" do
      status = client.update("I'm plurking with Plurky!", "says")
      expect(status).to be_a Hashie::Mash
      expect(status.content_raw).to eq "I'm plurking with Plurky!"
    end
  end

end
