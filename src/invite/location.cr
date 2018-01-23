module Invite
  class Location
    class Exception < ::Exception; end

    class InvalidLatitude < Exception
      def initialize(value)
        super("Invalid latitude: #{value}")
      end
    end

    class InvalidLongitude < Exception
      def initialize(value)
        super("Invalid longtitude: #{value}")
      end
    end

    OFFICE_LATITUDE    = 53.339428
    OFFICE_LONGTITUDE  = -6.257664
    EARTH_RADIUS_IN_KM =      6371
    TO_RADIANS         = Math::PI / 180

    getter lat : Float64
    getter lng : Float64
    getter distance_in_km : Float64

    def initialize(@lat, @lng)
      raise InvalidLatitude.new(@lat) if @lat < -90.0 || @lat > 90.0
      raise InvalidLongitude.new(@lng) if @lng < -180.0 || @lng > 180.0
      @distance_in_km = calculate_distance(@lat, @lng)
    end

    # Calculate distance using Haversine formula
    # Source: https://www.movable-type.co.uk/scripts/latlong.html
    def calculate_distance(lat, @lng)
      theta1 = @lat * TO_RADIANS
      theta2 = OFFICE_LATITUDE * TO_RADIANS
      delta_theta = theta2 - theta1
      delta_lambda = (@lng - OFFICE_LONGTITUDE) * TO_RADIANS
      a = Math.sin(delta_theta / 2) * Math.sin(delta_theta / 2) +
          Math.cos(theta1) * Math.cos(theta2) *
          Math.sin(delta_lambda / 2) * Math.sin(delta_lambda / 2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      (EARTH_RADIUS_IN_KM * c).round(2)
    end
  end
end
