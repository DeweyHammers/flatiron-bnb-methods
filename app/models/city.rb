class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(date1, date2)
    date1 = date1.split('-')
    date2 = date2.split('-')
    start = DateTime.new(date1[0].to_i, date1[1].to_i, date1[2].to_i)
    stop = DateTime.new(date2[0].to_i, date2[1].to_i, date2[2].to_i)

    listing_arr = []

    self.listings.all.each do |listing|
      listing.reservations.all.each do |reservation|
        listing_arr << listing unless (start..stop).cover? reservation.checkin
      end
    end

    listing_arr
  end
end

