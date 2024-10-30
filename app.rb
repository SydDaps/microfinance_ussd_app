# frozen_string_literal: true

post '/ussd' do
  USSD::Engine.start(params).prompt_data
end
