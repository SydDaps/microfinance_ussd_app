module USSD
  module LoanRequestMenu
    class Page2 < Bianchi::USSD::Page
      def request
        render_and_await(message)
      end

      def response
        case session.input_body
        when '1'
          render_and_end('Your loan is being processed')
        when '2'
          render_and_end('Your loan request has been cancelled')
        when '3'
          redirect_to_loan_request_menu_page_1
        else
          render_and_await("Invalid input. \n" + message)
        end
      end

      private

      def message
        amount = session.store.get('amount')
        <<~MSG
          You are about to request a loan of $#{amount}. Confirm?
          1. Yes
          2. No

          3. Back
        MSG
      end
    end
  end
end
