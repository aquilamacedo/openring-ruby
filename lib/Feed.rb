require 'rss'
require 'nokogiri'
require 'erb'
require 'date'

class Feed
  def process_title(url)
    raise NoMethodError, "#{self.class} #process_title method is abstract and must be implemented in the subclass"
  end
   
  def process_link(rss_content)
    raise NoMethodError, "#{self.class} #process_link method is abstract and must be implemented in the subclass"
  end

  def process_post_content(rss_content)
    raise NoMethodError, "#{self.class} #process_post_content method is abstract and must be implemented in the subclass"
  end

  def process_post_date(rss_content)
    raise NoMethodError, "#{self.class} #process_post_date method is abstract and must be implemented in the subclass"
  end
 
  def process_post_link(rss_content)
    raise NoMethodError, "#{self.class} #process_post_link method is abstract and must be implemented in the subclass"
  end
  
  def process_post_title(rss_content)
    raise NoMethodError, "#{self.class} #process_post_title method is abstract and must be implemented in the subclass"
  end
end

class Atom < Feed
  def process_title(rss_content)
    atom_title = rss_content.title.content 

    return atom_title
  end

  def process_link(rss_content)
    atom_link = rss_content.link.href
    atom_uri_link = URI(atom_link)
    atom_base_url = "#{atom_uri_link.scheme}://#{atom_uri_link.host}"

    return atom_base_url
  end

  def process_post_content(rss_content)
    atom_content = rss_content.items[0].content.content
    atom_content_parser = Nokogiri::HTML(atom_content)
    atom_content_beauty = atom_content_parser.css('p')[0].text
    atom_content_beauty_limit = atom_content_beauty[0..256] + "…"

    return atom_content_beauty_limit
  end

  def process_post_date(rss_content)
    atom_pub_date = rss_content.items[0].published.content

    atom_format = Date.parse(atom_pub_date.to_s)
    atom_format = atom_format.strftime('%b %d, %Y')

    return atom_format
  end

  def process_post_title(rss_content)
    atom_post_title = rss_content.items[0].title.content

    return atom_post_title
  end

  def process_post_link(rss_content)
    atom_post_link = rss_content.items[0].link.href

    return atom_post_link
  end
end

class Rss < Feed
  def process_title(rss_content)
    rss_title = rss_content.channel.title

    return rss_title
  end

  def process_link(rss_content)
    rss_link = rss_content.channel.link

    return rss_link
  end

  def process_post_content(rss_content)
    rss_content = rss_content.items[0].description
    rss_content_beauty = Nokogiri::HTML(rss_content).text
    rss_content_beauty_limit = rss_content_beauty[0..256] + "…"

    return rss_content_beauty_limit
  end

  def process_post_date(rss_content)
    rss_pub_date = rss_content.items[0].date

    rss_format = Date.parse(rss_pub_date.to_s)
    rss_format = rss_format.strftime('%b %d, %Y')

    return rss_format
  end

  def process_post_title(rss_content)
    rss_post_title = rss_content.items[0].title

    return rss_post_title
  end

  def process_post_link(rss_content)
    rss_post_link = rss_content.items[0].link

    return rss_post_link
  end
end
