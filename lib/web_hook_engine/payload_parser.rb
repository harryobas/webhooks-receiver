class WebHookEngine::PayloadParser
  class << self
    def parse_payload(payload)
      push = Push.new
      payload['commits'].each do |c|
        push_commit = Commit.new
        push_commit.sha = c['sha']
        push_commit.tickets = extract_tickets(c['message'])
        push_commit.date = DateTime.parse(c['date'])
        push_commit.author = Author.new({auth_id: c['author']['id'], name: c['author']['name'], email: c['author']['email']})
        push.commits << push_commit
      end
      push.repository = Repository.new({repo_id: payload['repository']['id'], name: payload['repository']['name']})
      push.pushed_at = DateTime.parse(payload['pushed_at'])
      push.pusher = Pusher.new({pusher_id: payload['pusher']['id'],
         name: payload['pusher']['name'], email: payload['pusher']['email']})
      push
    end
    private
    def extract_tickets(message)
      message.split("\n\n").last.split(':').last.strip
    end
  end
end
