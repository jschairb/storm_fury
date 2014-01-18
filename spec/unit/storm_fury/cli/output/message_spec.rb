require_relative '../../../unit_spec_helper'

module StormFury::CLI::Output
  describe Message do
    let(:text) { "this is a message." }

    describe ".error" do
      it "codes the text on red" do
        expect(Message.error(text)).to match(/\e\[41m.+\e\[0m/)
      end

      it "includes an error designator" do
        expect(Message.error(text)).to include("[ERROR]")
      end

      it "includes the text" do
        expect(Message.error(text)).to include(text)
      end
    end

    describe ".failure" do
      it "codes the text red" do
        expect(Message.failure(text)).to match(/\e\[31m.+\e\[0m/)
      end

      it "includes an failure designator" do
        expect(Message.failure(text)).to include("[FAILURE]")
      end

      it "includes the text" do
        expect(Message.failure(text)).to include(text)
      end
    end

    describe ".success" do
      it "codes the text red" do
        expect(Message.success(text)).to match(/\e\[32m.+\e\[0m/)
      end

      it "includes an success designator" do
        expect(Message.success(text)).to include("[SUCCESS]")
      end

      it "includes the text" do
        expect(Message.success(text)).to include(text)
      end
    end
  end
end
