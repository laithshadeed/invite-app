module Invite
  class Customer
    property user_id : Int32
    property name : String
    property location : Location

    def initialize(@user_id, @name, @location); end
  end
end
