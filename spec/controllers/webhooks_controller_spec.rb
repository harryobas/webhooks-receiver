require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do

  describe "POST #receive" do
    context "JSON received" do
      before(:each){request.headers['Content-Type'] = 'application/json'}
      let(:json_file){"#{Rails.root}/spec/fixtures/push_payload.json"}
      let(:data){JSON.parse(File.read(json_file))}
      let(:subject){post :receive, params: {webhook: data.symbolize_keys}}
      it "calls payload parser" do
        request.env['RAW_POST_DATA'] = File.read(json_file)
        WebHookEngine::PayloadParser.expects(:parse_payload).with(data)
        subject
      end
      it "calls repo" do
        request.env['RAW_POST_DATA'] = File.read(json_file)
        #parsed_payload = WebHookEngine::PayloadParser.parse_payload(data)
        WebHookEngine::Repo.expects(:persist).returns(true)
        subject
      end
      it "calls tickets updater" do
        request.env['RAW_POST_DATA'] = File.read(json_file)
        WebHookEngine::TicketsUpdater.expects(:send_issue_updates)
        subject
      end
    end
  end
end
