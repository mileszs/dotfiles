# From the great David Baldwin (github.com/baldwindavid)
require 'rubygems'
require 'net/http'
require 'uri'
require 'json'
require 'cgi'

API_KEY = '822c0fc517a5d2219c9e5a7389fe5648'
API_VERSION = 2
WORDS_PER_LINE = 4
RELATIONSHIP_TYPES = {
  'syn' => 'synonyms',
  'ant' => 'antonyms',
  'rel' => 'related',
  'sim' => 'similar',
  'usr' => 'user suggested'
  }

# Allow multi-word searches without quotes.  Yay.
search_term = ARGV.join(' ')
# URL encode command line string
search_term_url = CGI::escape(search_term)

uri = URI.parse("http://words.bighugelabs.com/api/#{API_VERSION}/#{API_KEY}/#{search_term_url}/json")
response = Net::HTTP.get(uri)

if !response.empty?
  puts "\n--------------------------------------------------"
  puts ' Thesaurus entries for "' + search_term + "\"\n"
  puts "--------------------------------------------------\n\n"

  parts = JSON.parse(response) if response
  parts.each do |part, relationships|
    puts " " + part + 's'
    print " "
    (part.size + 1).times {print '-'}
    puts "\n"

    RELATIONSHIP_TYPES.sort.reverse.each do |abbrev, title|
      if relationships[abbrev]
        words = relationships[abbrev].sort
        puts "  #{title}:"
        i = 1
        words.each do |word|
          print "    " if i == 1
          print word
          print ', ' unless i == words.size
          print "\n    " if (i % WORDS_PER_LINE == 0) && (i != words.size)
          i+=1
        end
        puts "\n\n"
      end
    end
  end
  puts "\n"
else
  puts "\n--------------------------------------------------"
  puts ' No entries for "' + search_term + '"'
  puts "--------------------------------------------------\n\n"
end
