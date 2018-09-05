require 'wild_dig/version'
require 'byebug'

module WildDig

  WILDCARD = :*.freeze
  extend self

  def dig(collection, *keys)
    return collection unless collection.respond_to?(:dig)
    return collection.dig(*keys) unless keys.include?(WILDCARD)
    #TODO deep clone the collection?
    new_collection = deep_clone(collection)
    current_key = keys.shift
    if current_key == WILDCARD
      wildcard(new_collection, keys)
    else
      normal(new_collection, current_key, keys)
    end
  end

  private

  def wildcard(collection, keys)
    if keys.empty?
      collection.map { |key, value| value }
    else
      # Find a way to transform the collection here
      collection.map { |key, value| dig(value, *keys) }
    end.first
  end

  def normal(collection, current_key, keys)
    result = collection.dig(current_key)
    return result if keys.empty?
    dig(result, *keys)
  end

  def deep_clone(collection)
    {}.tap do |new_collection|
      collection.each do |key, value|
        new_collection[key] = value
      end
    end
  end
end
