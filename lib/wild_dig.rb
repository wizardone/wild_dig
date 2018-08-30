require 'wild_dig/version'
require 'byebug'

module WildDig
  WILDCARD = :*.freeze
  extend self
  def dig(collection, *keys)
    #return collection.dig(*keys) unless keys.include?(WILDCARD)

    current_key = keys.shift
    if current_key == WILDCARD
      #Do wildcard magic
      collection.each do |key, value|
        (keys.empty? || value.nil?) ? value : dig(value, *keys)
      end
    else
      #Do regular magic
      value = collection[current_key]
      (keys.empty? || value.nil?) ? value : dig(value, *keys)
    end
  end
end
