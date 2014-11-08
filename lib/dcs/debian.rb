require "thor"
require "open-uri"
require "nokogiri"
require "colored"
require "dcs/debian/version"
require "dcs/debian/helper"

module Dcs
  module Debian

    class Command < Thor

      def self.define_commands(name)
        desc "#{name} KEYWORD", "Search debian/#{name} file"
        define_method(name) do |*args, &block|
          dcs_search(name, args[0])
        end
      end

      define_commands :control
      define_commands :rules
      define_commands :changelog

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
