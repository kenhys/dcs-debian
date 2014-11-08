require "thor"
require "open-uri"
require "nokogiri"
require "colored"
require "dcs/debian/version"
require "dcs/debian/helper"

module Dcs
  module Debian
    # Your code goes here...

    class Command < Thor

      desc "control [KEYWORDS]", ""
      def control(arg)
        client = Searcher.new
        client.pagination("control", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

      desc "changelog [KEYWORDS]", ""
      def changelog(arg)
        client = Searcher.new
        client.pagination("changelog", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

      desc "rules [KEYWORDS]", ""
      def rules(arg)
        client = Searcher.new
        client.pagination("rules", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

    end
  end
end
