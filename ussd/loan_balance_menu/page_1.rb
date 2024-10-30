module USSD
  module LoanBalanceMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await(message)
      end

      def response
        case session.input_body
        when '0'
          redirect_to_main_menu_page_1
        else
          render_and_await("Invalid input.\n" + message)
        end
      end

      def message
        balance = 34

        "Your current loan balance is $#{balance}. Press 0 to go back."
      end
    end
  end
end
