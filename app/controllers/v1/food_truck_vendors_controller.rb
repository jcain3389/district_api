class V1::FoodTruckVendorsController < ApplicationController
  def index
    @food_truck_vendors = FoodTruckVendor.all
    render json: @food_truck_vendors
  end
end