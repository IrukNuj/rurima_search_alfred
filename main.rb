require 'net/http'
require 'json'

base_url = 'https://docs.ruby-lang.org/ja/search/api:v1/'

delete_url = 'https://docs.ruby-lang.org/ja/search/'

queries = ARGV[0].split.map { |query| "query:#{query}/" }
request_url = base_url + queries.join('')

res = Net::HTTP.get(URI.parse(request_url))
response = JSON.parse(res)

entries = response['entries']

puts '<items>'
entries.each_with_index do |_entry, _i|
  puts <<~EOS
    <item uid="#{_i}" arg="#{_entry['documents'].last['url'].gsub(delete_url, '')}">
      <title>#{_entry['signature']}</title>
      <subtitle>#{_entry['summary']}</subtitle>
    </item>
  EOS
end
puts '</items>'
