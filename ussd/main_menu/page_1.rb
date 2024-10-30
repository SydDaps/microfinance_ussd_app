module USSD
  module MainMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await(request_body)
      end

      def response
        case session.input_body
        when '1'
          redirect_to_loan_request_menu_page_1
        when '2'
          redirect_to_loan_balance_menu_page_1
        when '3'
          render_and_end('Good Bye.')
        else
          render_and_await("Invalid input. \n" + request_body)
        end
      end

      private

      def request_body
        <<~MSG
          1. Request a Loan
          2. Check Loan Balance
          3. Exit
        MSG
      end
    end
  end
end
