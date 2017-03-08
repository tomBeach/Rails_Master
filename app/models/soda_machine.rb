class SodaStockObserver

  def self.manage_stock(transaction, transition)
    puts "Removing 1 from the #{transaction.selection}" count
  end

  def self.after_transition(transaction, transition)
    puts "#{transition.attribute} was: #{transition.from}, #{transition.attribute} is: #{transition.to}"
  end

end

class SodaTransaction
  attr_reader :selection

  state_machine :state, initial: :awaiting_selection do
    after_transition :on => :soda_dropped, :do => SodaStockObserver.method(:manage_stock)
    after_transition SodaStockObserver.method(:after_transition)

    event :button_press do
      transition :awaiting_selection => :dispense_soda, if: :in_stock?
    end

    event :soda_dropped do
      transition :dispense_soda => :complete
    end
  end

  def button_press(selection)
    @selection = selection
    super
  end

  def in_stock?
    stock_levels[@selection] > 0
  end

  def stock_levels
    {
      dr_pepper: 100,
      sprite: 10,
      root_beer: 0,
      cola: 8
    }
  end
end
