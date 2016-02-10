class FoodTruckVendor < ActiveRecord::Base
  require 'open-uri'
  def self.import_from_foodtruckfiesta
    doc = Nokogiri::HTML(open('http://foodtruckfiesta.com'))

    doc.css('ul.xoxo.blogroll.active_truck_list li a').each do |link|
      name = link.content.gsub(/\([^()]*\)/,"").strip
      FoodTruckVendor.create(name: name)
    end
  end
end