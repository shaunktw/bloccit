class Location < ActiveRecord::Base
  has_many :posts

  def self.find_or_create_place(place_id, loc)
  	pl = Location.where(place_id: place_id).first 
    pl = Location.generate_location(loc) if pl.blank?
    pl
  end

  def self.generate_location(loc)
  	pl = new
    pl.address = loc.address
    pl.place_id = loc.data["place_id"]
    pl.postal_code = loc.postal_code
    pl.country = loc.country
    pl.save

    return pl
  end
end
