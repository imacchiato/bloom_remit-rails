require 'rails_helper'

RSpec.describe BloomRemit do

  it "is configurable" do
    BloomRemit.configure do |c|
      c.token = "token"
      c.secret = "secret"
      c.agent_id = "agent_id"
      c.on_txn_response = OnTxnResponse
      c.sandbox = true
    end

    expect(described_class.token).to eq "token"
    expect(described_class.secret).to eq "secret"
    expect(described_class.agent_id).to eq "agent_id"
    expect(described_class.sender_id_method).to eq :bloom_remit_id
    expect(described_class.on_txn_response).to eq OnTxnResponse
  end

  describe ".sender_id_method" do
    it "is configuratble" do
      described_class.configure {|c| c.sender_id_method = "asd"}
      expect(described_class.sender_id_method).to eq "asd"
    end
  end

end
