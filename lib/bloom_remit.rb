require "ar_after_transaction"
require "virtus"
require "active_model"
require "storext"
require "sidekiq"
require "light-service"
require "disposable"
require "disposable/callback"
require "trailblazer"
require "trailblazer/operation/model"
require "trailblazer/operation/controller"
require "trailblazer/operation/representer"
require "trailblazer/operation/dispatch"
require "reform/rails"
require "roar-rails"
require "active_support/core_ext/module/attribute_accessors"
require "bloom_remit_client"
require "bloom_remit/engine"

module BloomRemit

  mattr_accessor :token
  mattr_accessor :secret
  mattr_accessor :agent_id
  mattr_accessor :sandbox
  mattr_accessor :host
  mattr_reader :sender_id_method_default
  mattr_accessor :on_txn_response
  @@sender_id_method_default = :bloom_remit_id
  mattr_accessor :sender_id_method
  self.sender_id_method = self.sender_id_method_default

  def self.configure(&block)
    yield self
  end

end
