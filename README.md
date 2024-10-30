# Microfinance USSD App

This is a simple USSD (Unstructured Supplementary Service Data) application, built using the **Bianchi framework**. Bianchi is a framework I developed to simplify the creation of USSD applications in Ruby.

## Prerequisites

- **Ruby**: Ensure Ruby is installed on your machine.
- **Bundler**: (Optional) Install Bundler to handle dependencies:
```bash
gem install bundler
```

## Installation

2. **Install dependencies**:
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

- If the user enters **1**, they are redirected to the loan request menu, located in the `loan_request_menu/page_1` file.
- If the user enters **2**, they are redirected to the loan balance menu, located in the `loan_balance_menu/page_1` file.
- If the user enters **3**, the session is terminated and closed with a `render_and_end` method, displaying a message: "Goodbye."

This flow ensures a seamless user experience by guiding them through the menu options while maintaining an open session for efficient interaction.