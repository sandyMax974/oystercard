require 'journey' 

describe Journey do 
  let(:card) {Oystercard.new} 
  before do 
    card.top_up(10)
  end 
  
  it "applies a fine when tapping out, having not tapped in" do 

    expect {card.tap_out("somewhere")}.to change{card.balance}.by(-Oystercard::PENALTY)
  end   


    
end 
