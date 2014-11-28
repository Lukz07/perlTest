$(function(){

	var pageToGo = 0;

	function init(){
		renderPage(pageToGo=1);
	};

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

				$.each(jsonData.inventories, function(i, val){
					var editBtn = $('<button id="edit" type="button" class="btn btn-default btn-xs">Edit</button>')
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
						.append('<td>'+val.total_quantity+'</td>')
						.append('<td>'+val.available+'</td>')
						.append($('<td></td>').append(editBtn)));
				});

				var prev = $('<li><a id="prev" href="#"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>');
				// $(prev).closest('a').bind('click', function(){
				// 	e.preventDefault();
				// 	if(pageToGo>=2)
				// 		renderPage(pageToGo-1)
				// });
				
				var next = $('<li><a  id="next" href="#"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>');
				// $(next).closest('a').bind('click', function(){
				// 	e.preventDefault();
				// 	if(pageToGo>=1 || pageToGo<=(totalPages-1))
				// 		renderPage(pageToGo+1)
				// });

				$('.pagination').html('');

				for (var v=1; v<=totalPages; v++) {
					
					if(v==1) { 
						$('.pagination').append($(prev)
							.on('click', 'a', function(e){
									e.preventDefault();
									console.log("prev: "+pageToGo);
									if(pageToGo>=2){
										renderPage(pageToGo-=1)
									}
								})
							);
					}

					$('.pagination').append(
						$('<li></li>')
						.append($('<a href="#">'+v+'</a>')
							.bind('click', function(e){
								e.preventDefault();
								pageToGo = $(this).html();
								renderPage(pageToGo)
							})));

					if (v==totalPages) {
						$('.pagination li:last-child').after($(next)
							.on('click', 'a', function(e){
								e.preventDefault();
								console.log("next: "+pageToGo);
								if(pageToGo>=1 || pageToGo<=(totalPages-1)){
									renderPage(pageToGo+=1)
								}
							})

						);
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