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

      desc "control KEYWORD", ""
      def control(arg)
        client = Searcher.new
        client.pagination("control", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

      desc "changelog KEYWORD", ""
      def changelog(arg)
        client = Searcher.new
        client.pagination("changelog", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

      desc "rules KEYWORD", ""
      def rules(arg)
        client = Searcher.new
        client.pagination("rules", arg) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arg}/, '\&'.red_on_yellow)
        end
      end

      def method_missing(id, *arguments)
        client = Searcher.new
        client.pagination(id.to_s, arguments[0]) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{arguments[0]}/, '\&'.red_on_yellow)
        end
      end

    end
  end
end
