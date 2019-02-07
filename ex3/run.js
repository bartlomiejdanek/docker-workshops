var redis = require("redis"),
    client = redis.createClient({host: "localhost", port: 6380, db: 15})
client.set("somekey", ["somevalue"], redis.print);
client.get("somekey", function(err, reply) {
    console.log(reply);
});
