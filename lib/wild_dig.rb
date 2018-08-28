require 'wild_dig/version'
require 'byebug'

class Hash
  WILDCARD = :*.freeze
  def wild_dig(*keys)
    return dig(*keys) unless keys.include?(WILDCARD)
  end
end
