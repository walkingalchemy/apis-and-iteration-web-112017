require 'rest-client'
require 'json'
require 'pry'


#make the web request
def get_characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def get_character_movies_from_api(character)
  character_hash = get_characters
  character_data = character_hash["results"].find { |data| data["name"] == character}
  film_urls = character_data["films"]
  film_data = film_urls.collect { |data| JSON.parse(RestClient.get(data)) }
  film_data
end

def show_all_characters
  character_hash = get_characters
  character_data = character_hash["results"].collect { |data| data["name"]}
  character_data.each.with_index(1) do |name, index|
    puts "#{index}. #{name}"
end
end

def parse_character_movies(films_hash)
  films_hash.each.with_index(1) do |data, index|
    puts "#{index} #{data['title']}, #{data['director']}, #{data['release_date']}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
#
# def most_films
#   character_hash = get_characters
#   most_films = character_hash["results"].max_by { |data| data["flims"].size}
#   binding.pry
# end
#
# most_films
