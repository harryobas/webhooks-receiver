class WebhooksController < ApplicationController
  before_action :set_payload

  def receive
    parsed_payload = WebHookEngine::PayloadParser.parse_payload(@payload)
    WebHookEngine::Repo.persist(parsed_payload)
    render nothing: true
  end

  private

  def set_payload
    if request.headers['Content-Type'] == 'application/json'
      @payload = params[:webhook]
    else
      @payload = params.as_json
    end
  end

end
