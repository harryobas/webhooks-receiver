class WebHookEngine::TicketsUpdater
  URL = "https://webhook.site/2a661dda-fa74-4378-986d-463a2c20f630"
  class << self
    def send_issue_updates(parsed_payload)
      update_payload = {}
      parsed_payload.commits.each do |c|
        update_payload[:query] = "state ready_for_release"
        update_payload[:issues] = extract_issues(c.tickets)
        update_payload[:comments] = "see SHA ##{c.sha}"
      end
      RestClient::Request.execute(method: :get, url: URL, payload: update_payload.to_json)
    end
    private
    def extract_issues(tickets)
      tickets.split(',').map{|t| {id: t.sub(/#/, "")}}
    end
  end
end
