require 'redis'

redis = Redis.new(host: 'localhost', port: 6380, db: 15)

redis.set('key', ['value'])

puts redis.get('key')
