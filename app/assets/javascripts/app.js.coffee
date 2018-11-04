
$ = jQuery

$(document).on "ready page:load", ->
	cursoBackend.connect();
	$('#follow_btn').on "click", ->
		friend = $(this).data("friend")
		boton = $(this)
		$.ajax "/usuario/follow", 
		type: "POST"
		dataType: "JSON"
		data: {usuario: { friend_id: friend }}
		success: (data)->
			console.log data
			boton.slideUp()
		error: (err)->
			console.log err
			alert "No hemos podido crear la amistad"
