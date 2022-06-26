require 'Feed'

RSpec.describe Feed do
    it "testing title" do
        a = Atom.new
        a_value = a.process_title('https://chaws.me/feed.xml')
        expect(a_value).to be_truthy
    end
end