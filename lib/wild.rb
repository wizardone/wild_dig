require 'wild/version'
require 'byebug'

module Wild

  WILDCARD = :*.freeze
  extend self

  def dig(collection, *keys)
    return collection unless collection.respond_to?(:dig)
    return collection.dig(*keys) unless keys.include?(WILDCARD)

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
      collection.map { |key, value| value }.first
    else
      if collection.is_a?(Hash)
        collection.map { |key, value| dig(value, *keys) }.first
      elsif collection.is_a?(Array)
        collection.map { |key, _value| dig(key, *keys) }.reject(&:nil?)
      end
    end
  end

  def normal(collection, current_key, keys)
    result = collection.dig(current_key)
    return result if keys.empty?
    dig(result, *keys)
  end

  def deep_clone(collection)
    return collection.dup unless collection.respond_to?(:each)

    case collection
    when Hash
      {}.tap do |new_collection|
        collection.each do |key, value|
          new_collection[key] = deep_clone(value)
        end
      end
    when Array
      collection.map { |el| deep_clone(el) }
    else
      raise ArgumentError
    end
  end
end
