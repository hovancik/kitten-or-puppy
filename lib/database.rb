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
end
