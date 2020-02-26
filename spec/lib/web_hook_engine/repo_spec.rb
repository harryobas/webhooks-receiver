require 'rails_helper'

RSpec.describe WebHookEngine::Repo do

  let(:parsed_push_payload) do
    push_payload = JSON.parse(File.read("#{Rails.root}/spec/fixtures/push_payload.json"))
    WebHookEngine::PayloadParser.parse_payload(push_payload)
  end

  let(:parsed_release_payload) do
    release_payload = JSON.parse(File.read("#{Rails.root}/spec/fixtures/release_payload.json"))
    WebHookEngine::PayloadParser.parse_payload(release_payload)
  end

  describe ".persist" do
    context "with parsed push payload" do
      it "inserts a new push record into the database" do
        expect(WebHookEngine::Repo.persist(parsed_push_payload)).to eq true
        expect(Push.all.size).to be > 0
      end
    end
    context "with parsed release payload" do
      it "inserts a new release record into the database" do
        expect(WebHookEngine::Repo.persist(parsed_release_payload)).to eq true
        expect(Release.all.size).to be > 0  
      end
    end
  end

end
