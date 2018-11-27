class Transfer
  attr_accessor :receiver, :sender, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? and @receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending'
      if sender.valid? and receiver.valid?
        if sender.balance >= amount
          sender.balance -= amount
          receiver.balance += amount
          self.status = 'complete'
        else
          self.status = 'rejected'
          "Transaction rejected. Please check your account balance."
        end
      end
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      sender.balance += amount
      receiver.balance -= amount
      self.status = 'reversed'
    end
  end
end
