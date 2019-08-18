require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Test Drug",
        :description => "Test Description",
        :published => false,
        :category => :otc
      ),
      Product.create!(
        :name => "Test Drug",
        :description => "Test Description",
        :published => false,
        :category => :prescription
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Test Drug".to_s, :count => 2
    assert_select "tr>td", :text => "Test Description".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
