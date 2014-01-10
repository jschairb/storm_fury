require_relative '../../unit_spec_helper'

module StormFury::CLI
  describe Servers do
    let(:args)           { [] }
    let(:global_options) { {} }
    let(:options)        { {} }
    let(:servers)        { Servers.new(global_options, options, args) }

    describe ".create" do
      let(:server) { double(:server) }

      it "creates a server" do
        server.should_receive(:create)
        Servers.should_receive(:new).with(global_options, options, args, anything).
          and_return(server)

        Servers.create(global_options, options, args)
      end
    end

    describe ".new" do
      it "sets the args attribute" do
        expect(servers.args).to eql(args)
      end

      it "sets the global_options attribute" do
        expect(servers.global_options).to eql(global_options)
      end

      it "sets the options attribute" do
        expect(servers.options).to eql(options)
      end
    end
  end
end
