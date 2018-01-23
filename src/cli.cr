require "option_parser"
require "./invite/*"

module Invite
  class CLI
    def self.run
      file = "./data.txt"
      max_distance_to_office_in_km = 100.00

      OptionParser.parse! do |opts|
        opts.banner = "Usage: invite [arguments]"

        opts.on(
          "-f FILE",
          "--file=FILE",
          "Customer data, default is ./data.txt") { |name| file = name }

        opts.on(
          "-d DISTANCE_IN_KM",
          "--distance=DISTANCE_IN_KM",
          "Max distance for customers in KM, default is 100") { |name| max_distance_to_office_in_km = name.to_f }

        opts.on(
          "-h",
          "--help",
          "Show this help") { puts opts; exit }

        opts.on(
          "-v",
          "--version",
          "Prints version") { puts Invite::VERSION; exit }
      end

      raw_customers = Parser.read(file)
      InvitedCustomers.new(raw_customers, max_distance_to_office_in_km).get.each do |c|
        puts "#{c.user_id}\t#{c.name}\t\t#{c.location.distance_in_km}"
      end

      exit
    end
  end
end

begin
  Invite::CLI.run
rescue ex : Exception
  "#{ex}\n".to_s(STDERR)
  exit 1
end
