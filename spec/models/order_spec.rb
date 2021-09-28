require 'rails_helper'

RSpec.describe Order, type: :model do

  it 'should calculate total price of the order' do
    item1 = create(:item)
    item2 = create(:item, price: 20)

    order = create(:order)
    order.items << item1
    order.items << item2

    order.calculate_total
    expect(order.total).to eq(30)
  end

end
