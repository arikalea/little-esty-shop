require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions)}
  end

  before :each do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")
    @customer7 = Customer.create!(first_name: "Molly", last_name: "Rae")

    @merchant1 = Merchant.create!(name: "Jimbo")
    @merchant2 = Merchant.create!(name: "Linda")

    @item1 = Item.create!(name: "spatula", description: "fold them eggs", unit_price: 14.00, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "bowling ball", description: "roll em if you got em", unit_price: 68.00, merchant_id: @merchant2.id)

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled", created_at: "1990-03-23 21:40:46")
    @invoice2 = Invoice.create!(customer_id: @customer2.id, status: "in progress")
    @invoice3 = Invoice.create!(customer_id: @customer3.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice4 = Invoice.create!(customer_id: @customer4.id, status: "cancelled")
    @invoice5 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice6 = Invoice.create!(customer_id: @customer6.id, status: "completed")
    @invoice7 = Invoice.create!(customer_id: @customer7.id, status: "completed")

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 28.00, status: "pending" )
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 68.00, status: "shipped" )
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 68.00, status: "packaged" )

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction2 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction3 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction4 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction5 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction6 = Transaction.create!(invoice_id: @invoice1.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction7 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction8 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction9 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction10 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction11 = Transaction.create!(invoice_id: @invoice2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction12 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction13 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction14 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction15 = Transaction.create!(invoice_id: @invoice3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction16 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction17 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction18 = Transaction.create!(invoice_id: @invoice4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction19 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction20 = Transaction.create!(invoice_id: @invoice5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction21 = Transaction.create!(invoice_id: @invoice6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction22 = Transaction.create!(invoice_id: @invoice7.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: false)
  end

  describe "instance methods" do
    describe "Format time" do
      it "Formats timestamp for created at with day, month date, year" do
        # may need to change this expected later
        expect(@invoice_item1.invoice.format_time).to_not eq(@invoice_item1.invoice.created_at)
      end
    end

    describe "Customer name" do
      it "returns customer name" do
        expect(@invoice1.customer_name).to eq("Bob Gu")
      end
    end
  end
end
