require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received(order)" do
    mail = Notifier.order_received(orders(:one))
	
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    #assert_equal :order.email, mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped.", mail.subject
	
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

end
