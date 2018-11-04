// en el video es window.easyDesigns
// Todo funciono muy bien, excepto la gema jquery-tmpl que no encontraba o nunca cargo el template
window.cursoBackend = {
	connect: function() {
		window.cursoBackend.socket = io.connect('http://localhost:5001');

		window.cursoBackend.socket.on('rt-change', function (data) {
			console.log(data);
			$.tmpl("post", data).prependTo('#actividades');
		});
	}
}