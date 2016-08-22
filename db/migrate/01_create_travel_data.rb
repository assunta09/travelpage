class CreateTravelData < ActiveRecord::Migration
  def change
    create_table :traveldata do |t|
     t.string :name
     t.string :location
   end
  end
end
