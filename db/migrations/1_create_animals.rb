# run as `sequel -m db/migrations sqlite://db/app.db` from root
require 'sequel'
Sequel.migration do
  up do
    create_table :animals do
      primary_key :id
      String :imgur_id
      unique :imgur_id
      String :link
      String :type
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:animals)
  end
end
