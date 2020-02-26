class WebHookEngine::Repo
  class << self
    def persist(parsed_payload)
      parsed_payload.save
    end
  end
end
