require 'rails_helper'

RSpec.describe WebHookEngine::PayloadParser do
  let(:push_payload){JSON.parse(File.read("#{Rails.root}/spec/fixtures/push_payload.json"))}
  let(:release_payload){JSON.parse(File.read("#{Rails.root}/spec/fixtures/release_payload.json"))}
  let(:pull_payload){JSON.parse(File.read("#{Rails.root}/spec/fixtures/pull_request_payload.json"))}

  describe ".parse_payload" do
    context "with push payload" do
      it "returns a push model" do
        parsed_payload = WebHookEngine::PayloadParser.parse_payload(push_payload)
        expect(parsed_payload).to be_a Push
      end
    end
    context "with release payload" do
      it "returns a release model" do
        parsed_payload = WebHookEngine::PayloadParser.parse_payload(release_payload)
        expect(parsed_payload).to be_a Release
      end
    end
    context "with pull reqiest payload" do
      it "returns a pull request model" do
        parsed_payload = WebHookEngine::PayloadParser.parse_payload(pull_payload)
        expect(parsed_payload).to be_a Pull
      end
    end

  end
end
