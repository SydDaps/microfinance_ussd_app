module USSD
  class Engine
    def self.start(params)
      Bianchi::USSD::Engine.start(params, provider: :africastalking) do
        menu :main, initial: true
        menu :loan_request
        menu :loan_balance
      end
    end
  end
end
