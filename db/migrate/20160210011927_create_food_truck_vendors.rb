class CreateFoodTruckVendors < ActiveRecord::Migration
  def change
    create_table :food_truck_vendors do |t|
      t.string :name, null: false, default: ""
    end
  end
end
