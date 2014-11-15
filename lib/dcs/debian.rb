require "thor"
require "open-uri"
require "nokogiri"
require "colored"
require "dcs/debian/version"
require "dcs/debian/helper"

module Dcs
  module Debian

    class Command < Thor

      attr_accessor :verbose

      def self.define_commands(name)
        desc "#{name} KEYWORD [--n_limit VAL] [--page_limit VAL]", "Search debian/#{name} file"
        option :verbose, :default => false
        option :page_limit, :default => 1
        option :n_limit, :default => 5
        define_method(name) do |*args, &block|
          @verbose = options[:verbose]
          @page_limit = options[:page_limit].to_i
          @n_limit = options[:n_limit].to_i
          dcs_search(name.to_s, args[0])
        end
      end

      define_commands :control
      define_commands :rules
      define_commands :changelog

      private

      def dcs_search(file, keyword)
        options = {
          :verbose => @verbose,
          :page_limit => @page_limit,
          :n_limit => @n_limit
        }
        client = Searcher.new(options)
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
