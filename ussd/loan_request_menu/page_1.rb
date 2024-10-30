module USSD
  module LoanRequestMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await(message)
      end

      def response
        amount = session.input_body.strip

        render_and_await("Invalid amount. \n#{message}") unless valid_amount? amount

        session.store.set('amount', amount)

        redirect_to_next_page
      end

      private

      def message
        'Enter loan amount:'
      end

      def valid_amount?(amount)
        amount.to_f > 0 && amount.match?(/\A\d+(\.\d+)?\z/)
      end
    end
  end
end
