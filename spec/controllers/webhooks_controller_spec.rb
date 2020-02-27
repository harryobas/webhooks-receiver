require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do

  describe "POST #receive" do
    context "JSON received" do
      before(:each){request.headers['Content-Type'] = 'application/json'}
      let(:json_file){"#{Rails.root}/spec/fixtures/push_payload.json"}
      let(:data){JSON.parse(File.read(json_file))}
      let(:subject){post :receive, params: {webhook: data}}
      it "calls payload parser" do
        request.env['RAW_POST_DATA'] = File.read(json_file)
        WebHookEngine::PayloadParser.expects(:parse_payload).with(data).returns(Push.any_instance)
        subject
      end
    end
  end
end
