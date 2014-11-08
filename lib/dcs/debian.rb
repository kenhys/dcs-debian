require "thor"
require "open-uri"
require "nokogiri"
require "colored"
require "dcs/debian/version"
require "dcs/debian/helper"

module Dcs
  module Debian

    class Command < Thor

      desc "control KEYWORD", ""
      def control(arg)
        dcs_search("control", arg)
      end

      desc "changelog KEYWORD", ""
      def changelog(arg)
        dcs_search("changelog", arg)
      end

      desc "rules KEYWORD", ""
      def rules(arg)
        dcs_search("rules", arg)
      end

      private

      def dcs_search(file, keyword)
        client = Searcher.new
        client.pagination(file, keyword) do |context|
          puts sprintf("%s (%s)",
                       context[:path].bold.white_on_green,
                       context[:url].white_on_blue)
          puts context[:pre].gsub(/#{keyword}/, '\&'.red_on_yellow)
        end
      end

      def method_missing(id, *arguments)
        dcs_search(id.to_s, arguments[0])
      end

    end
  end
end
