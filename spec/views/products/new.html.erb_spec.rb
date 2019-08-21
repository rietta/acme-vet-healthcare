require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :name => "MyString",
      :published => false,
      :category => :prescription
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input[name=?]", "product[name]"
      
      assert_select "input[name=?]", "product[published]"

      assert_select "input[name=?]", "product[category]"
    end
  end
end
