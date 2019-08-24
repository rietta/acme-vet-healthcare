# frozen_string_literal: true

require 'rest-client'

class RequestStateApproval
  APPROVAL_URL = 'https://stormy-anchorage-94836.herokuapp.com/approvals'

  def initialize(veterinarian_number:, order_id:, product_id:, product_name:)
    @veterinarian_number = veterinarian_number
    @order_id = order_id
    @product_id = product_id
    @product_name = product_name
  end

  def run
    3.times do |i|
      post
      break if success?

      sleep(i**2) # increasing backoff
    end
  end

  def success?
    @response&.code == 200
  end

  def result
    return {} unless success?

    OpenStruct.new(JSON.parse(@response.body))
  end

  def retry?
    @response.nil? || @response&.code == 504
  end

  private

  def json_payload
    {
      'veterinarian_number' => @veterinarian_number,
      'order_id' => @order_id,
      'product_id' => @product_id,
      'product_name' => @product_name
    }
  end

  def post
    @response = RestClient.post(
      APPROVAL_URL,
      json_payload.to_json,
      content_type: :json,
      accept: :json
    )
  end


end
