module BloomRemit
  module Txns
    module Contracts
      class Create < Reform::Form

        model ::BloomRemit::Txn
        property :sender_type
        property :sender_id
        property :amount
        property :account_name
        property :account_id
        property :target_slug
        property :owner_id
        property :owner_type
        property :external_id
        property :recipient_id

      end
    end
  end
end
