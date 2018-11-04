var io = require('socket.io').listen(5001);

var redis = require('redis');

var redis_client = redis.createClient();

redis_client.subscribe('rt-change');

io.on('connection', function (socket) {
	redis_client.on('message', function (channel, message) {
		socket.emit('rt-change', JSON.parse(message));
	});
});