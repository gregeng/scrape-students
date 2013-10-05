
  # Scraping Most Voted Hackernews
  require 'pry'
  require 'nokogiri'
  require 'open-uri'


  # student_profile = Nokogiri::HTML(open('http://students.flatironschool.com/students/greg_eng.html'))
  student_index_page = Nokogiri::HTML(open('http://students.flatironschool.com'))

  #index page

  student_links = 
  student_index_page.css("div.blog-title div.big-comment h3 a").collect do |link|
    "http://students.flatironschool.com/#{link['href']}"  ## i dunno why this href works -- its cause its a hash!!! thanks vivian :D
  end

  student_hysterical_taglines = 
  student_index_page.css("div.blog-title p.home-blog-post-meta").collect do |tagline|
      tagline.text
  end

  ## since there are errors when generating the has, i'm not sure how to get the hysterical taglines in there.

  ##### Collect data for students at all the links.

student_profiles_hash = {}

    student_links.each do |student|
    begin

      
      student_profile = Nokogiri::HTML(open(student))
      name = student_profile.css("h4.ib_main_header").text.to_sym
      
      quote = student_profile.css("div#testimonial-slider").text.gsub("\n","").strip!
      biography = student_profile.css("div.services p")[0].text.gsub("\n","").strip!
      social_links =  student_profile.css('div.social-icons a')
      twitter =  student_profile.css('div.social-icons a')[0].first[1]
      linkedin = student_profile.css('div.social-icons a')[1].first[1]
      github = student_profile.css('div.social-icons a')[2].first[1]
      blog = student_profile.css('div.social-icons a')[3].first[1]


# Nokogiri::HTML(open('http://students.flatironschool.com/students/sam_owens.html')).css('div.social-icons a')[3].first[1]

  
      student_profiles_hash[name] = {}
      student_profiles_hash[name][:quote] = quote
      student_profiles_hash[name][:biography] = biography
      student_profiles_hash[name][:social_links] = {}
      
      student_profiles_hash[name][:social_links][:twitter] = twitter
      student_profiles_hash[name][:social_links][:linkedin] = linkedin
      student_profiles_hash[name][:social_links][:github] = github
      student_profiles_hash[name][:social_links][:blog] = blog


      # student_profile.css('div.social-icons a')[0].first[1]  

      # student_profile.css('div.social-icons a').collect {|link| link['href']}

    rescue
    
      puts "#{student} just created an error"
    
    end
  end

student_profiles_hash

#### Making SQL Statements


names = student_profiles_hash.collect do |name, about_me|
    name 
end

quotes = names.collect do |name|
  student_profiles_hash[name.to_sym][:quote]
end

biography = names.collect do |name|
  student_profiles_hash[name.to_sym][:biography]
end

twitter = names.collect do |name|
  student_profiles_hash[name.to_sym][:social_links][:twitter]
end

linkedin = names.collect do |name|
  student_profiles_hash[name.to_sym][:social_links][:linkedin]
end

blog = names.collect do |name|
  student_profiles_hash[name.to_sym][:social_links][:blog]
end

github = names.collect do |name|
  student_profiles_hash[name.to_sym][:social_links][:github]
end

output = File.open("scrape_insert.sql", 'w')
names.each do |student_name|
  output << "INSERT INTO students (name) VALUES (\"#{student_name}\");\n"
end

i = 0
loop do 
  output << "-- UPDATE students SET quote = #{quotes[i]} WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET biography = \"#{biography[i]}\" WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET twitter = \"#{twitter[i]}\" WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET linkedin = \"#{linkedin[i]}\" WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET blog = \"#{blog[i]}\" WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET github = \"#{github[i]}\" WHERE id = #{i+1};\n"
  i += 1  
  break if i == names.length
end

output.close