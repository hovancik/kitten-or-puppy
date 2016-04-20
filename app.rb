require 'sinatra'
require_relative 'lib/database'
require 'dotenv'

# Main App
class App < Sinatra::Base
  Dotenv.load
  database = Database.new
  configure { set :server, :puma }

  get '/' do
    kitten = database.random_row('animals', "type = 'kitten'")
    @kitten_url, @kitten_id = url_and_id_from(kitten)
    puppy = database.random_row('animals', "type = 'puppy'")
    @puppy_url, @puppy_id = url_and_id_from(puppy)
    @kitten_percent = database.vote_percentage('kitten')
    @vote_count = database.vote_count
    erb :index
  end

  get '/vote/:animal_id' do
    database.vote(params['animal_id'])
    redirect to('/')
  end

  def m_url(link)
    splitted = link.split('.')
    splitted[-2] << 'm'
    splitted[0].slice!('http:')
    splitted.join('.')
  end

  def url_and_id_from(animal)
    [m_url(animal[:link]), animal[:id]]
  end
end
