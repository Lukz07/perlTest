$(function(){
	function init(){
		renderPage(1)
	};

	function renderPage(pageNumber){
		$.ajax({
			url: path+'/page/'+pageNumber,
			success: function(data){

				//vacio el contenido de la tabla para mostrar la nueva
				$('table tbody').html('');
				$('.pagination').html('');

				var jsonData;
				var totalPages = null;
				totalPages = data.total_pages/10;
				jsonData = data.json_data;				
					
				$.each(jsonData, function(i, val){

					var editBtn = $('<td><button class="btn btn-default btn-xs">Edit</button></td>')
									.click(function(e){
										e.preventDefault();
										var id = $(this).closest('tr').data('id');
										//editar pantalla: edito href para pasar id por paramatro.
										window.location.href = editPath+"/"+id;
									});

					$('table tbody').append(
						$('<tr data-id="'+val.film_id+'"></tr>')
							.append('<td>'+val.film_id+'</td>')
							.append('<td>'+val.title+'</td>')
							.append('<td>'+val.description+'</td>')
							.append('<td>'+val.release_year+'</td>')
							.append('<td>'+val.rating+'</td>')
						);
				});

				for (var v=1; v<=totalPages; v++) {
					$('.pagination').append(
						$('<li></li>')
						.append($('<a href="#">'+v+'</a>')
							.bind('click', function(e){
								e.preventDefault();
								//window.location.href = pagePath+"/"+v;
								var pageToGo = $(this).html();
								renderPage(pageToGo)
								console.log(pageToGo);
							})));
				}

				//$('.pagination').children('a').click(function (e){});
			},
			error: function(error) {
				alert(error.statusText);
			}
		})	
	}

	init();
})