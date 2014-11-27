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
				var totalPages = null;
				totalPages = data.total_pages;
				
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

				var prev = $('<li><a id="prev" href="#"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>');
				var next = $('<li><a  id="next" href="#"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>');
				
				$('.pagination').html('');

				for (var v=1; v<=totalPages; v++) {
					
					if(v==1) { 
						$('.pagination').append(prev);
						debugger;
					}

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

					if (v==totalPages) {
						$('.pagination li:last-child').after(next);
					}
				};

				// $('.pagination').append(next);

			},
			error: function(data){
				alert(data.responseText);
			}
		})	
	};

	init();
})