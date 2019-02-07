require 'redis'

redis = Redis.new(host: 'localhost', port: 6380, db: 15)

redis.set('key', ['value', 'value2'])

puts redis.get('key')
