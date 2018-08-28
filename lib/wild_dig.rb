require 'wild_dig/version'
require 'byebug'

#{a: {b: {c: true}}}.wild_dig(:a, :b)
module WildDig
  WILDCARD = :*.freeze
  extend self
  def dig(collection, *keys)
    return collection.dig(*keys) unless keys.include?(WILDCARD)

    value = collection[keys.shift]
    (keys.empty? || value.nil?) ? value : dig(value, *keys)
  end
end
