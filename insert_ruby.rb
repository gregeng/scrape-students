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
  output << "INSERT INTO students (name) VALUES '#{student_name}';"
end


# This isnt working because of the --
# i = 0
# loop do 
#   output << "UPDATE students SET quote = '#{quotes[i]}' WHERE id = #{i+1};"
#   i += 1  
#   break if i == names.length
# end

i = 0
loop do 
  output << "UPDATE students SET biography = \"#{biography[i]}\" WHERE id = #{i+1};"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET twitter = \"#{twitter[i]}\" WHERE id = #{i+1};"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET linkedin = \"#{linkedin[i]}\" WHERE id = #{i+1};"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET blog = \"#{blog[i]}\" WHERE id = #{i+1};"
  i += 1  
  break if i == names.length
end

i = 0
loop do 
  output << "UPDATE students SET github = \"#{github[i]}\" WHERE id = #{i+1};"
  i += 1  
  break if i == names.length
end

output.close