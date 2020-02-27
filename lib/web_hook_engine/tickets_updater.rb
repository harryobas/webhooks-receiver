class WebHookEngine::TicketsUpdater
  URL = "https://webhook.site/2a661dda-fa74-4378-986d-463a2c20f630"
  class << self
    def send_issue_updates(parsed_payload)
      if parsed_payload.class == Push
        send_push_commit_updates(parsed_payload)
      else
        send_release_commit_updates(parsed_payload) if parsed_payload.class == Release
      end
    end

    private

    def send_push_commit_updates(payload)
      update_payload = {}
      payload.commits.each do |c|
        update_payload[:query] = "state ready for release"
        update_payload[:issues] = extract_issues(c.tickets)
        update_payload[:comments] = "see SHA ##{c.sha}"
      end
      send_payload(update_payload)
    end

    def send_release_commit_updates(payload)
      update_payload = {}
      payload.commits.each do |c|
        update_payload[:query] = "state #{payload.action}"
        update_payload[:issues] = extract_issues(c.tickets)
        update_payload[:comments] = "Released in #{payload.tag_name}"
      end
      send_payload(update_payload)
    end

    def send_payload(update_payload)
      RestClient::Request.execute(method: :post, url: URL,
        payload: update_payload.to_json, headers: {content_type: :json})
    end

    def extract_issues(tickets)
      tickets.split(',').map{|t| {id: t.sub(/#/, "")}}
    end
  end
end
