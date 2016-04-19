require_relative 'imgur'
require_relative 'database'
require 'dotenv'

Dotenv.load
db = Database.new

%w(kitten puppy).each do |animal|
  Imgur.gallery_images(animal).each do |image|
    begin
      db.insert(
        :animals,
        imgur_id: image['id'],
        link: image['link'],
        type: animal,
        created_at: Time.now,
        updated_at: Time.now
      )
    rescue Sequel::UniqueConstraintViolation
      # we have this one olready
      print 'x'
    end
    print '.'
  end
  print "\nImported #{animal}\n"
end
