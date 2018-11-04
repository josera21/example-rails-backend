# La clase redis sale de la gema redis y el $ delante de la variable redis, indica 
# que es una variable global
$redis = Redis.new(host: 'localhost', port: 6379)