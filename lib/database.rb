# Allows connection to our sqlite DB.
# we use sqlite db located in File.expand_path('../../db/app.db', __FILE__)
class Database
  require 'sequel'
  attr_reader :db

  def initialize
    db_file = File.expand_path('../../db/app.db', __FILE__)
    @db = Sequel.sqlite(db_file)
  end

  # insert data into table
  # insert(:animals, {imgur_id: 'asd1fg', type: 'kitten'})
  def insert(table, data)
    dataset = @db[table]
    dataset.insert(data)
  end

  # select random row from table
  def random_row(table, where)
    @db
      .fetch("SELECT * FROM #{table} WHERE #{where} ORDER BY RANDOM() LIMIT 1")
      .to_a[0]
  end

  # vote for image
  def vote(animal_id)
    insert(
      :votes,
      animal_id: animal_id,
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  # percentage of votes for kittens
  def vote_percentage(type)
    animals_votes = @db["select * from votes where animal_id in \
      (select id from animals where type = '#{type}')"]
    begin
      (animals_votes.count / @db[:votes].count.to_f * 100).round
    rescue FloatDomainError
      50 # we have no data, it's 50:50
    end
  end

  def vote_count
    @db[:votes].count
  end
end
