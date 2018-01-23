require "./spec_helper"

describe Invite do
  describe "InvitedCustomers" do
    it "should select customers within 200KM & sort them by user_id" do
      raw_customers = Invite::Parser.read("#{__DIR__}/data/test_file.txt")
      customers = Invite::InvitedCustomers.new(raw_customers, 200).get
      customers.size.should eq 3
      customers[0].user_id.should eq 10
      customers[1].user_id.should eq 12
      customers[2].user_id.should eq 16
    end
  end
  describe "Location" do
    it "should correctly calculate distance" do
      location = Invite::Location.new(lat: 53.2451022, lng: -6.238335)
      location.distance_in_km.should eq 10.57
    end

    it "should ensure latitude is between -90 & +90" do
      expect_raises(Invite::Location::InvalidLatitude, "Invalid latitude") do
        location = Invite::Location.new(lat: 92.0, lng: -6.238335)
      end
    end

    it "should ensure longtitude is between -180 & + 180" do
      expect_raises(Invite::Location::InvalidLongitude, "Invalid longtitude") do
        location = Invite::Location.new(lat: 53.2451022, lng: 181.0)
      end
    end
  end

  describe "Customer" do
    it "should set user_id, name & location" do
      location = Invite::Location.new(lat: 53.2451022, lng: -6.238335)
      customer = Invite::Customer.new(user_id: 1, name: "Laith Shadeed", location: location)
      customer.name.should eq "Laith Shadeed"
      customer.user_id.should eq 1
      customer.location.should eq location
    end
  end

  describe "Parser" do
    it "should parse correctly formatted file" do
      raw_customers = Invite::Parser.read("#{__DIR__}/data/test_file.txt")
      raw_customers.size.should eq 4
      raw_customers[0].user_id.should eq 12
      raw_customers[0].name.should eq "Christina McArdle"
      raw_customers[0].latitude.should eq 52.986375
      raw_customers[0].longitude.should eq -6.043701
    end

    it "should parse correctly utf-8 file" do
      raw_customers = Invite::Parser.read("#{__DIR__}/data/utf_8_file.txt")
      raw_customers.size.should eq 1
      raw_customers[0].name.should eq "ليث شديد"
    end

    it "should raise exception when file is empty" do
      expect_raises(Invite::Parser::EmptyFile, "Empty file") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/empty_file.txt")
      end
    end

    it "should raise exception when file has no permission" do
      expect_raises(Invite::Parser::NoPermission, "No permission to read file") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/no_permission.txt")
      end
    end

    it "should raise exception when file has invalid json" do
      expect_raises(JSON::ParseException, "Unexpected char") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/invalid_json.txt")
      end
    end

    it "should raise exception when file has invalid schema" do
      expect_raises(JSON::ParseException, "Missing json attribute: user_id") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/invalid_schema.txt")
      end
    end

    it "should raise exception when file has invalid int" do
      expect_raises(ArgumentError, "Invalid Int32") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/invalid_int32.txt")
      end
    end

    it "should raise exception when file has invalid float" do
      expect_raises(ArgumentError, "Invalid Float64") do
        raw_customers = Invite::Parser.read("#{__DIR__}/data/invalid_float64.txt")
      end
    end
  end
end
