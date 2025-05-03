module Distance
  class Calculator
    def self.distance_from(lat, lon)
      dlat = to_radians(lat - OFFICE.dig(:mumbai, :lat))
      dlon = to_radians(lon - OFFICE.dig(:mumbai, :lon))

      a = Math.sin(dlat / 2) ** 2 + Math.cos(to_radians(OFFICE.dig(:mumbai, :lat))) * Math.cos(to_radians(lat)) * Math.sin(dlon / 2) ** 2

      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      return (EARTH_RADIUS_KM * c).round(2)
    end

    private

    def self.to_radians(degrees)
      degrees * Math::PI / 180
    end
  end
end
