require 'wild_dig/version'
require 'byebug'

module WildDig
  WILDCARD = :*.freeze
  extend self
  def dig(collection, *keys, called: nil)
    #return collection.dig(*keys) unless keys.include?(WILDCARD)

    current_key = keys.shift
    if current_key == WILDCARD
      if keys.empty?
        collection.map { |key, value| value }
      else
        collection.map { |key, value| dig(value, *keys, called: true) }
      end.first
    else
      return collection unless collection.respond_to?(:dig)
      result = collection.dig(current_key)
      return result if keys.empty?
      dig(result, *keys)
    end
  end
end
