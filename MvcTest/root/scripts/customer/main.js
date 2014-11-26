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

					var editBtn = $('<button id="edit" type="button" class="btn btn-default btn-xs">Edit</button>')
					.click(function(e){
						e.preventDefault();

						var id = $(this).closest('tr').data('id');
						//editar pantalla: edito href para pasar id por paramatro.
						window.location.href = editPath+"/"+id;
					});

					$('table tbody').append(
					$('<tr data-id="'+val.customer_id+'"></tr>').append('<td>'+val.customer_id+'</td>')
								.append('<td>'+val.first_name+'</td>')
								.append('<td>'+val.last_name+'</td>')
								.append($('<td></td>').append(editBtn)));
				});
			},
			error: function(data){
				alert(data.responseText);
			}
		})	
	};

	init();
})