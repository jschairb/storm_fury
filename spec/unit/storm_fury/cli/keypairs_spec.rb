require_relative '../../unit_spec_helper'

module StormFury::CLI
  describe Keypairs do
    let(:args)           { [] }
    let(:global_options) { {} }
    let(:options)        { {} }
    let(:keypairs)        { Keypairs.new(global_options, options, args) }

    describe ".create" do
      let(:keypair) { double(:keypair) }

      it "creates a keypair" do
        keypair.should_receive(:create)
        Keypairs.should_receive(:new).with(global_options, options, args, anything).
          and_return(keypair)

        Keypairs.create(global_options, options, args)
      end
    end

    describe ".new" do
      it "sets the args attribute" do
        expect(keypairs.args).to eql(args)
      end

      it "sets the global_options attribute" do
        expect(keypairs.global_options).to eql(global_options)
      end

      it "sets the options attribute" do
        expect(keypairs.options).to eql(options)
      end
    end
  end
end
