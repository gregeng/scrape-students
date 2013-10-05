require 'nokogiri'
require 'open-uri'
# require 'sqlite3'


# stories = hacker_news.css("table table tr")

# Node Set =  array

# scraping the most voted hacker news
# get all the posts on hacker news
# figure out their vote count
# sort thta tarray b or whatever the vote count


# get data into a hash
# inject this into SQL

#image jobs github link

# after we get all the hases and stuff

# then you figure out how to connect the sql to the parsed data

# Scraping Most Voted Hackernews
require 'nokogiri'
require 'open-uri'

# Get all the Posts on Hackernews
doc = Nokogiri::HTML(open('http://ycombinator.com/'))
# Figure out their vote count
stories = hacker_news.css("span.comhead")

# stories.first.class
# stories.class
# stories.first.parent.css("a").to_s
# stories.first.parent.css("a").to_text

stories.each do |source_doc|
  title = source_doc.parent.css("a").to_text
  href = source.doc.parent.css("a").attr("href").to_s
  #raise href.inspect
  stories << { :title, :href => href }

# get story array to mirror subtext array

# Sort that array by vote count

vote_counts = hacker_news.css("td.subtext.span").collect {|e| e.text }
vote_counts.each_with_index do |vote, i|
  stories[i][:vote_count]

stories.each do |story_hash|