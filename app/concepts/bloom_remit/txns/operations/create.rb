module BloomRemit
  module Txns
    module Operations
      class Create < Trailblazer::Operation

        include Model
        model Txn, :create

        contract Contracts::Create

        include Dispatch
        callback :after_create, Callbacks::AfterCreate

        def process(params)
          validate(params[:txn]) do |f|
            f.model.secret = SecureRandom.uuid
            f.save
            dispatch! :after_create
          end
        end

      end
    end
  end
end