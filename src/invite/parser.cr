require "json"

module Invite
  class Mapper
    JSON.mapping(
      user_id: Int32 | String,
      name: String,
      latitude: String | Float64,
      longitude: String | Float64,
    )
  end

  class Parser
    class Exception < ::Exception; end

    class EmptyFile < Exception
      def initialize(path)
        super("Empty file: #{path}")
      end
    end

    class NoPermission < Exception
      def initialize(path)
        super("No permission to read file: #{path}")
      end
    end

    def self.read(path : String)
      raise NoPermission.new(path) if !File.readable?(path)
      raise EmptyFile.new(path) if File.empty?(path)
      raw_customers = [] of Mapper
      File.each_line(path) do |line|
        raw = Mapper.from_json(line)
        raw.user_id = raw.user_id.to_i
        raw.latitude = raw.latitude.to_f
        raw.longitude = raw.longitude.to_f
        raw_customers << raw
      end
      raw_customers
    end
  end
end
