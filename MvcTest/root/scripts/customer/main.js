$(function(){
	function init(){
		renderPage(1);
	};

	$('.pagination a').click(function(e, page){
		e.preventDefault();
		page = $(this).html();
		renderPage(page);
	});

	function renderPage(pageNumber){
		$.ajax({
			url: path+'/page/'+pageNumber,
			success: function(data){

				var jsonData= null;
				jsonData = data.json_data;
				
				//vacio el contenido de la tabla para mostrar la nueva
				$('table tbody').html('');

				$.each(jsonData, function(i, val){
					$('table tbody').append('<tr id="'+i+'"></tr>');
					$('table tbody #'+val.customer_id+'').append('<td>'+val.customer_id+'</td>');
					$('table tbody #'+val.customer_id+'').append('<td>'+val.first_name+'</td>');
					$('table tbody #'+val.customer_id+'').append('<td>'+val.last_name+'</td>');
					$('table tbody #'+val.customer_id+'').append('<td><button id="'+val.customer_id+'" type="button" class="btn btn-default btn-xs">Edit</button></td>');
					$('table tbody #'+val.customer_id+' button').bind('click', function(id){
						id = $(this).attr('id');
						
						//editar pantalla: edito href para pasar id por paramatro.
						window.location.href = "editview/"+id;
					});
				});
			},
			error: function(data){
				alert(data.responseText);
			}
		})	
	};

	init();
})