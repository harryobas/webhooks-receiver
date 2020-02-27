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

  let(:url){"https://webhook.site/2a661dda-fa74-4378-986d-463a2c20f630"}

  let(:update_payload_push) do
    {
      query: "state ready for release",
      issues: [
        {
          id: "sp-131"
        }
      ],
      comment: "see SHA f66997d4630d353901a64f39df5f92d22e4bc634"
    }
  end

  let(:update_payload_release) do
    {
      query: "state released",
      issues: [
        {
          id: "happ-1224"
        }
      ],
      comment: "released in 1.0.1"
    }
  end

  let(:update_push_args){{method: :get, url: url, payload: update_payload_push.to_json}}

  describe ".send_issue_updates" do
    context "with parsed push payload" do
      it "sends push commit updates" do
        #RestClient::Request.expects(:execute).with(update_push_args)
        res = WebHookEngine::TicketsUpdater.send_issue_updates(parsed_push_payload)
        expect(res.code).to eq 200   
      end
    end
  end
end
