require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)
  if get_character_data(character)
    get_films_data(get_films_urls(character))
  else
    puts "That character does not exist. Try one of these:"
    full_character_list.each {|char| puts char}
  end
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


end

def get_character_data(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters_data = character_hash["results"]
  character_data = characters_data.find do |search_character|
    search_character["name"].downcase == character.downcase
  end
end

def get_results
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters_data = character_hash["results"]
end

def full_character_list
  get_results.map {|character| character["name"]}
end

# all_characters = RestClient.get('http://www.swapi.co/api/people/')
# character_hash = JSON.parse(all_characters)
# x = get_results
# y = full_character_list
#
# binding.pry
def get_films_urls(character)
  get_character_data(character)["films"]
end

def get_films_data(film_urls)
  film_urls.map do |film_url|
    JSON.parse(RestClient.get(film_url))
  end
end

def validate(item)
  item ? item : "Unavailable"
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
    films_hash.each do |film|
      puts "Title : #{validate(film["title"])}"
      puts "#{validate(film["opening_crawl"][0..136])}..."
      puts "Directed by #{validate(film["director"])}"
      puts "+" + ( "--pew--" * 4) + "+"
    end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash
    parse_character_movies(films_hash)
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
