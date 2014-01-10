require_relative '../../unit_spec_helper'

module StormFury::Resource
  describe Server do
    let(:attributes) { {} }
    let(:server)     { Server.new(attributes) }
    let(:service)    { StormFury.service }

    describe ".create" do
      let(:server) { double("server") }

      it "creates a server" do
        server.should_receive(:create)
        Server.should_receive(:new).and_return(server)

        Server.create(attributes)
      end
    end

    describe ".new" do
      it "sets the #attributes attribute" do
        expect(server.attributes).to eq(attributes)
      end

      it "sets the #service attribute" do
        expect(server.service).to eq(service)
      end
    end

    describe "#create" do
      before do
        server.stub_chain(:service, :servers).and_return(servers)
      end

      let(:response) { {} }
      let(:servers)  { double(:servers, create: response) }

      it "creates a server" do
        servers.should_receive(:create).with(attributes)
        server.create
      end

      context "when the service succeeds" do
        it "returns the response" do
          expect(server.create).to eq(response)
        end
      end

      context "when the service errors" do
        it "raises an error" do
          servers.stub(:create).and_raise(Fog::Compute::RackspaceV2::ServiceError)
          expect { server.create }.to raise_exception(ResourceNotCreatedError)
        end
      end
    end
  end
end
