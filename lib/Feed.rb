require 'rss'
require 'nokogiri'

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
  def process_title(url)
    atom_title = rss_content.title.content
    puts "Title: #{atom_title}"
  end

  def process_link(rss_content)
    # TODO
    atom_link = rss_content.link.href
    puts "Link: #{atom_link}"
  end

  def process_post_content(rss_content)
    atom_content = rss_content.items[0].content.content
    atom_content_parser = Nokogiri::HTML(atom_content)
    atom_content_beauty = atom_content_parser.css('p')[0].text
    atom_content_beauty_limit = atom_content_beauty[0..256] + "…"

    puts atom_content_beauty_limit
  end

  def process_post_date(rss_content)
    # Handle the format of data
    atom_pub_date = rss_content.items[0].published.content
    puts "Date: #{atom_pub_date}"
  end

  def process_post_title(rss_content)
    atom_post_title = rss_content.items[0].title.content
    puts "Post Title: #{atom_post_title}"
  end

  def process_post_link(rss_content)
    atom_post_link = rss_content.items[0].link.href
    puts "Post Link: #{atom_post_link}"
  end
end

class Rss < Feed
  def process_title(rss_content)
    rss_title = rss_content.channel.title
    puts "Title: #{rss_title}"
  end

  def process_link(rss_content)
    rss_link = rss_content.channel.link
    puts "Link: #{rss_link}"
  end

  def process_post_content(rss_content)
    rss_content = rss_content.items[0].description
    rss_content_beauty = Nokogiri::HTML(rss_content).text
    rss_content_beauty_limit = rss_content_beauty[0..256] + "…"
    puts rss_content_beauty_limit
  end

  def process_post_date(rss_content)
    rss_pub_date = rss_content.items[0].date
    puts "Date: #{rss_pub_date}"
  end

  def process_post_title(rss_content)
    rss_post_title = rss_content.items[0].title
    puts "Post Title: #{rss_post_title}"
  end

  def process_post_link(rss_content)
    rss_post_link = rss_content.items[0].link
    puts "Post Link: #{rss_post_link}"
  end
end


#rss = RSS::Parser.parse('/home/aqu1la/Documents/Repositorios/openring-ruby/lib/feed.xml')
rss = RSS::Parser.parse('https://drewdevault.com/blog/index.xml')

puts rss.feed_type

if rss.feed_type == 'atom'
  a = Atom.new

  a_atom = a.process_title(rss)
  b_atom = a.process_link(rss)
  c_atom = a.process_post_content(rss)
  d_atom = a.process_post_date(rss)
  e_atom = a.process_post_title(rss)
  f_atom = a.process_post_link(rss)
else
  b = Rss.new

  a_rss = b.process_title(rss)
  f_rss = b.process_link(rss)
  b_rss = b.process_post_content(rss)
  c_rss = b.process_post_date(rss)
  d_rss = b.process_post_title(rss)
  e_rss = b.process_post_link(rss)
end
