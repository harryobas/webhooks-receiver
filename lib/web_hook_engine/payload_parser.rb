class WebHookEngine::PayloadParser
  class << self

    def parse_payload(payload)
      if payload.key?('action') && payload['action'] == 'released'
        parse_release_payload(payload)
      elsif payload.key?('action') && payload['action'] == 'closed'|| payload['action'] == 'approved'|| payload['action'] == 'created'
        parse_pull_request_payload(payload)
      else
        parse_push_payload(payload)
      end
    end

    private

    def parse_push_payload(payload)
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

    def parse_release_payload(payload)
      release = Release.new
      payload['commits'].each do |c|
        release_commit = Commit.new
        release_commit.sha = c['sha']
        release_commit.tickets = extract_tickets(c['message'])
        release_commit.date = DateTime.parse(c['date'])
        release_commit.author = Author.new({auth_id: c['author']['id'], name: c['author']['name'], email: c['author']['email']})
        release.commits << release_commit
      end
      release.repository = Repository.new({repo_id: payload['repository']['id'], name: payload['repository']['name']})
      release.action = payload['action']
      release.released_at = DateTime.parse(payload["released_at"])
      release.release_id = payload['release']['id']
      release.tag_name = payload['release']['tag_name']
      release.author = Author.new({auth_id: payload['release']['author']['id'],
        name: payload['release']['author']['name'], email: payload['release']['author']['email']})
      release
    end

    def parse_pull_request_payload(payload)
      usr = User.new(usr_id: payload.dig('pull_request', 'user', 'id'), name: payload.dig('pull_request', 'user', 'name'),
      email: payload.dig('pull_request', 'user', 'email'))

      repo = Repository.new(repo_id: payload.dig('repository', 'id'), name: payload.dig('repository', 'name'))
      hd = Head.new(sha: payload.dig('pull_request', 'head', 'sha'))

      pull_req = PullRequest.new(request_id: payload.dig('pull_request', 'id'), number: payload.dig('pull_request', 'number'),
      state: payload.dig('pull_request', 'state'), title: payload.dig('pull_request', 'title'),
      commits: payload.dig('pull_request', 'commits'), user: usr, head: hd, body: payload.dig('pull_request', 'body'),
      created_at: DateTime.parse(payload['pull_request']['created_at']),
      updated_at: DateTime.parse(payload['pull_request']['updated_at']),
      closed_at: DateTime.parse(payload['pull_request']['closed_at']),
      merge_commit_sha: payload.dig('pull_request', 'merge_commit_sha'))

      pull = Pull.new
      pull.action = payload['action']
      pull.number = payload['number']
      pull.pull_request = pull_req
      pull.repository = repo
      pull
    end

    def extract_tickets(message)
      message.split("\n\n").last.split(':').last.strip
    end
  end
end
