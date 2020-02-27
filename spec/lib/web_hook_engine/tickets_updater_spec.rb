require 'rails_helper'

RSpec.describe WebHookEngine::TicketsUpdater do

  let(:parsed_push_payload) do
    push_payload = JSON.parse(File.read("#{Rails.root}/spec/fixtures/ready_for_release.json"))
    WebHookEngine::PayloadParser.parse_payload(push_payload)
  end

  let(:parsed_release_payload) do
    release_payload = JSON.parse(File.read("#{Rails.root}/spec/fixtures/released.json"))
    WebHookEngine::PayloadParser.parse_payload(release_payload)
  end

  describe ".send_issue_updates" do
    context "with parsed push payload" do
      it "sends push commit updates" do
        res = WebHookEngine::TicketsUpdater.send_issue_updates(parsed_push_payload)
        expect(res.code).to eq 200
      end
    end
    context "with parsed release payload" do
      it "sends release commit updates" do
        res = WebHookEngine::TicketsUpdater.send_issue_updates(parsed_release_payload)
        expect(res.code).to eq 200
      end
    end
  end
end
