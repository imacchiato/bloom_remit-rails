require 'rails_helper'

module BloomRemit
  RSpec.describe CreateTxn, vcr: {record: :once} do

    let(:external_id) { SecureRandom.hex(12) }

    it "creates a model and pays for the bill" do
      BloomRemit.configure do |c|
        c.token = ENV["BLOOM_REMIT_TOKEN"]
        c.secret = ENV["BLOOM_REMIT_SECRET"]
        c.agent_id = ENV["BLOOM_REMIT_AGENT_ID"]
        c.sandbox = true
      end

      user = create(:bloom_remit_dummy_sub_user)
      biller = create(:bloom_remit_dummy_biller, slug: "PLDT")
      payment = create(:bloom_remit_dummy_sub_payment)

      txn = CreateTxn.(
        target_slug: biller.slug,
        sender: user,
        amount: 800.0,
        account_name: "028109090",
        account_id: "Hooli X",
        owner: payment,
        recipient_id: "recipient-id",
        external_id: external_id,
      ).model

      expect(txn).to be_incomplete
      expect(txn.secret).to be_present
      expect(txn.sender_type).to eq "User"
      expect(txn.sender_id).to eq user.id.to_s
      expect(txn.owner_type).to eq "Payment"
      expect(txn.owner_id).to eq payment.id.to_s
      expect(txn.external_id).to eq external_id
      expect(txn.recipient_id).to eq "recipient-id"
    end

  end
end
