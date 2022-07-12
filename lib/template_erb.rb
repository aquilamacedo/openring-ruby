require_relative 'Feed.rb'

TEMPLATE_HTML = 'templates/in.html'

ATOM_CONTENTS = ['https://chaws.me/feed.xml', 'https://siqueira.tech/feed.xml', 'https://drewdevault.com/blog/index.xml']

process_title = []
process_link = []
process_post_content = []
process_post_date = []
process_post_title = []
process_post_link = []

for value in ATOM_CONTENTS do
  rss = RSS::Parser.parse(value)
  
  a = Atom.new
  b = Rss.new

  case rss.feed_type
    when 'atom'
      process_title.push(a.process_title(rss))
      process_link.push(a.process_link(rss))
      process_post_content.push(a.process_post_content(rss))
      process_post_date.push(a.process_post_date(rss))
      process_post_title.push(a.process_post_title(rss))
      process_post_link.push(a.process_post_link(rss))
    when 'rss'
      process_title.push(b.process_title(rss))
      process_link.push(b.process_link(rss))
      process_post_content.push(b.process_post_content(rss))
      process_post_date.push(b.process_post_date(rss))
      process_post_title.push(b.process_post_title(rss))
      process_post_link.push(b.process_post_link(rss))
  end
end


render = ERB.new(File.read(TEMPLATE_HTML),trim_mode: "%<>")

File.open('out.html', 'w') do |f|
  f.write render.result(binding)
end
