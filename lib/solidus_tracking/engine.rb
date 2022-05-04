# frozen_string_literal: true

require 'spree/core'
require 'solidus_tracking'

module SolidusTracking
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_tracking'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.after_initialize do
      if SolidusTracking.configuration.disable_builtin_emails && defined?(::Spree::OrderMailerSubscriber)
        confirm_email_subscription = ::Spree::Bus.subscription(:spree_order_mailer_send_confirmation_email)
        ::Spree::Bus.unsubscribe(confirm_email_subscription) if confirm_email_subscription
      end
    end
  end
end
