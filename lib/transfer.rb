class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction


    if @sender.balance>=@amount and @status == "pending" and self.valid?
      #binding.pry
      @receiver.deposit(@amount)
      @sender.withdwral(@amount)
      return @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer

    if @status == "complete"
      new_receiver = @sender
      new_sender = @receiver
      @sender = new_sender
      @receiver = new_receiver
      @status = "pending"
      execute_transaction
      @status = "reversed"
    end
  end


end
