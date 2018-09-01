require 'wild_dig/version'
require 'byebug'

module WildDig

  WILDCARD = :*.freeze
  extend self

  def dig(collection, *keys)
    return collection unless collection.respond_to?(:dig)
    return collection.dig(*keys) unless keys.include?(WILDCARD)

    current_key = keys.shift
    if current_key == WILDCARD
      wildcard(collection, keys)
    else
      normal(collection, current_key, keys)
    end
  end

  private

  def wildcard(collection, keys)
    if keys.empty?
      collection.map { |key, value| value }
    else
      collection.map { |key, value| dig(value, *keys) }
    end.first
  end

  def normal(collection, current_key, keys)
    result = collection.dig(current_key)
    return result if keys.empty?
    dig(result, *keys)
  end
end
