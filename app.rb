# frozen_string_literal: true

# before do
#   request.body.rewind
#   @params = ActiveSupport::JSON.decode(request.body.read)
#   content_type :json
# end

post '/ussd' do
  USSD::Engine.start(params).prompt_data
end
