# Microfinance USSD App

This is a simple USSD (Unstructured Supplementary Service Data) application, built using the **Bianchi framework**. Bianchi is a framework I developed to simplify the creation of USSD applications in Ruby.

## Prerequisites

- **Ruby**: Ensure Ruby is installed on your machine.
- **Bundler**: (Optional) Install Bundler to handle dependencies:
```bash
gem install bundler
```

## Installation

**Install dependencies**:
```bash
bundle install
```

## Running the App

Start the app using `rackup`:
```bash
rackup -p 3000
```

This will start a server on `http://localhost:3000`

## Build Process

The Bianchi engine utilizes a page menu approach to structure the USSD applications, with the entry point of this app defined in the `app.rb` file at the POST route `/ussd`.

### Session Management

The engine retrieves parameters from the provider and employs the session key along with the dialer's phone number to create a unique USSD session.

### Menu Structure

Given that our application has two main options, I created three menus:

1. **Main Menu**: This serves as the entry point for the application.
2. **Loan Request Menu**: Provides options related to loan applications.
3. **Loan Balance Menu**: Allows users to check their loan balances.

### Application Flow

When a user dials the short code hosting this USSD application, the request is processed by the engine. The engine first checks for an active session. If no active session exists, it renders the initial menu on **Page 1**.

The functionality of this engine is located in the `ussd/engine.rb` file.

Once the request reaches Page 1, we send a message to the dialer using the `render_and_await` method, which keeps the session open while waiting for a user response. When the user receives our request and sends a response, we process that input in the response method.

On the main menu page, we evaluate the user's input. If the user enters **1**, **2**, or **3**, we handle those options accordingly. For any other input, we resend the request and prompt the user to enter a valid option.

- If the user enters **1**, they are redirected to the loan request menu (Page 1), where the implementation is located in the `loan_request_menu/page_1` file.
- If the user enters **2**, they are redirected to the loan balance menu (Page 1), where the implementation is located in the `loan_balance_menu/page_1` file.
- If the user enters **3**, the session is terminated and closed with a `render_and_end` method, displaying a message: "Goodbye."

#### Loan Request Menu Flow

After selecting **1** on the main menu page, the user is redirected to the loan request menu page. On the first page of the loan request menu, we prompt the user to enter the desired loan amount. Once the user submits the amount, we first validate it to ensure it is a valid positive number or float. If the amount is invalid, we render the same page with an error message header: "Invalid Amount," allowing the user to re-enter a valid amount.

If the amount is valid, we store it in the session for retrieval on subsequent pages. We then proceed to the next page of the loan request menu, where we confirm if the user wants to proceed. This implementation is located in the `loan_request_menu/page_2` file.

- Press **1** for "Yes" to continue with the loan request.
- Press **2** for "No" to cancel the request.
- Press **3** to go back and re-enter the amount.

If the user responds with **1**, a message stating "Your loan is being processed" is displayed, and the session is closed. If the user responds with **2**, a message stating "Your loan request has been cancelled" is shown. If the user selects **3**, the previous page is rendered again, allowing the user to re-enter the amount.

#### Loan Balance Menu Flow

After selecting **2** on the main menu page, the user is redirected to the loan balance menu page. Since the amount is mocked to **500** in the request, once the user is redirected to this page, their balance is sent. We then await the user's response to check if they press **0** to exit. The implementation for this flow is located in the `loan_balance_menu/page_1` file.