module Invite
  class InvitedCustomers
    def initialize(raw_customers, max_distance_in_km)
      @customers = [] of Customer
      raw_customers.each do |raw|
        location = Location.new(lat: raw.latitude.to_f, lng: raw.longitude.to_f)
        customer = Customer.new(user_id: raw.user_id.to_i, name: raw.name, location: location)
        @customers << customer if customer.location.distance_in_km <= max_distance_in_km
      end
      @customers.sort! { |x, y| x.user_id <=> y.user_id }
    end

    def get
      @customers
    end
  end
end
