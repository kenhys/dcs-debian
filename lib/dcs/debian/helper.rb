module Dcs
  module Debian
    module Helper

      BASE_URL = "http://codesearch.debian.net"

      def pagination(target, keyword)
        next_uri = nil

        data = []
        unless next_uri
          next_uri = sprintf("%s/search?q=%s+path%%3Adebian%%2F%s",
                             BASE_URL, keyword, target)
        end

        until next_uri.nil?
          html = open(next_uri, "r:utf-8").read
          Nokogiri.parse(html) do |doc|
            doc.xpath("//ul[@id='results']/li").each do |li|
              entry = extract_entry(li, target)
              unless entry.empty?
                data << entry
              end
            end
            next_uri = extract_next_page_uri(doc)
          end
        end
        yield(data)
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
        raw = node.xpath("a/code").text
        raw =~ /.+debian\/(.+):(.+)/
        file = $1
        line = $2
        entry = {}
        case file
        when target
          p file
          entry[:file] = file
          entry[:line] = line
        else
          #p file
          #p line
        end
        entry
      end
    end
  end
end
