# run as `sequel -m db/migrations sqlite://db/app.db` from root
require 'sequel'
Sequel.migration do
  up do
    create_table :votes do
      primary_key :id
      foreign_key :animal_id, :animals
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table(:votes)
  end
end
