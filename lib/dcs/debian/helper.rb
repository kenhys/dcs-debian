module Dcs
  module Debian

    class Searcher

      attr_accessor :page_limit
      attr_accessor :n_limit

      BASE_URL = "http://codesearch.debian.net"

      def initialize
        @page_limit = 10
        @n_limit = 10
      end

      def pagination(target, keyword)
        next_uri = nil

        data = []
        unless next_uri
          next_uri = sprintf("%s/search?q=%s+path%%3Adebian%%2F%s%%24",
                             BASE_URL, keyword, target)
        end

        page = 1
        n = 1
        until next_uri.nil? or n > @n_limit or page > @page_limit
          html = open(next_uri, "r:utf-8").read
          Nokogiri.parse(html) do |doc|
            doc.xpath("//ul[@id='results']/li").each do |li|
              entry = extract_entry(li, target)
              unless entry.empty?
                if entry[:pre].include?(keyword)
                  n = n + 1
                  yield(entry)
                end
              end
            end
            next_uri = extract_next_page_uri(doc)
          end
          page = page + 1
        end
      end

      def extract_next_page_uri(node)
        next_uri = nil
        node.xpath("//div[@id='pagination']").each do |div|
          div.xpath("a").each do |a|
            case a.text
            when "Next page"
              next_uri = BASE_URL + a.attribute("href").text
            end
          end
        end
        next_uri
      end

      def extract_entry(node, target)
        url = BASE_URL + node.xpath("a").attribute("href").text
        raw = node.xpath("a/code").text
        raw =~ /(.+)debian\/(.+):(.+)/
        package = $1
        file = $2
        line = $3
        entry = {}
        case file
        when target
          entry[:path] = raw
          entry[:url] = url
          entry[:package] = package
          entry[:file] = file
          entry[:line] = line
          node.xpath("pre").each do |pre|
            data = []
            pre.children.each do |cnode|
              if cnode.kind_of?(Nokogiri::XML::Element)
                if cnode.name != "br"
                  data << indent + cnode.text
                end
              else
                data << indent + cnode.text
              end
            end
            entry[:pre] = data.join("\n")
          end
        else
          raise Error
        end
        entry
      end

      def indent
        " " * 2
      end

    end
  end
end
