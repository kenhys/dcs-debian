require "thor"
require "open-uri"
require "nokogiri"
require "dcs/debian/version"
require "dcs/debian/helper"

module Dcs
  module Debian
    # Your code goes here...

    class Command < Thor

      include Dcs::Debian::Helper

      desc "control [KEYWORDS]", ""
      def control(arg)
        pagination("control", arg) do |context|
          p context
        end
      end

    end
  end
end
