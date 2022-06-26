require 'rss'
require 'nokogiri'

class Feed
  def process_title(url)
    raise NoMethodError, "#{self.class} #process_title method is abstract and must be implemented in the subclass"
  end
end

class Atom < Feed
  def process_title(url)
    rss = RSS::Parser.parse(url)
    feed_title = rss.title.content

    return true
  end
end

