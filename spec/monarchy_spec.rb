require_relative '../monarchy'

describe Monarchy do
  before do
    @m = Monarchy.new "Charles"
  end

  describe ".birth" do
    context "given parent as nil" do
      it "raises argument error" do
        expect { @m.birth "Cat", nil }.to raise_error "No royal with that name."

      end
    end

    context "given a valid parent" do
      it "adds child to parent" do
        @m.birth "William", "Charles"
        expect @m.get_order_of_succession.to eql ["Charles", "William"]
      end
    end

    context "given invalid parent" do
      it "does not add child to tree" do
        expect {@m.birth "Cat", "Harry"}.to raise_error "No royal with that name."
      end
    end
  end

  describe ".death" do
    context "given invalid name" do
      it "raises NoSuchRoyalError error" do
        expect {@m.death "Cat"}.to raise_error "No royal with that name."
      end
    end

    context "given valid monarch name" do
      it "removes the name from succession" do
        @m.death "Charles"
        expect @m.get_order_of_succession.to eql ["William"]
      end
    end

    context "given valid monarch name" do
      it "removes the name from succession" do
        @m.death "Whilte"
        expect @m.get_order_of_succession.to eql ["William"]
      end
    end
  end

  describe "get_order_of_succession" do
    context "after entering a few children" do
      it "adds the children to the line of succession" do
        @m.birth "William", "Charles"
        @m.birth "Harry", "Charles"
        @m.birth "Perry", "Charles"
        @m.birth "Charlotte", "William"
        @m.birth "Andrea", "Harry"
        @m.birth "Whilte", "William"
        @m.birth "Farah", "Charlotte"
        expect @m.get_order_of_succession.to eql ["Charles", "William", "Charlotte", "Harry", "Andrea"]
      end
    end
  end


end


