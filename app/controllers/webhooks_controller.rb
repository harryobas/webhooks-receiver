class WebhooksController < ApplicationController

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = params[:webhook].as_json
    else
      data = params.as_json
    end
    @parsed_payload = WebHookEngine::PayloadParser.parse_payload(data)
    if @parsed_payload
      WebHookEngine::Repo.persist(@parsed_payload)
      WebHookEngine::TicketsUpdater.send_issue_updates(@parsed_payload)
    end
    render nothing: true
  end


end
