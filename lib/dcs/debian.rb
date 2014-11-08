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

      desc "changelog [KEYWORDS]", ""
      def changelog(arg)
        pagination("changelog", arg) do |context|
          p context
        end
      end

      desc "rules [KEYWORDS]", ""
      def rules(arg)
        pagination("rules", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path], context[:url])
          puts context[:pre]
        end
      end

    end
  end
end
