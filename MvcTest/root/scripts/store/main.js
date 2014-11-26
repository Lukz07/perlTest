$(function(){
	function init(){
		renderPage(1)
	};

	$('.pagination a').click(function(page){
		page = $(this).html();
		renderPage(page);
	});

	function renderPage(pageNumber){
		$.ajax({
			url: path+'/page/'+pageNumber,
			success: function(data){
				var jsonData;
				jsonData = data.json_data;

				console.log(jsonData);
					
				$.each(jsonData, function(i, val){
					$('table tbody').append('<tr id="'+i+'"></tr>');
					$('table tbody #'+val.staff_id+'').append('<td>'+val.staff_id+'</td>');
					$('table tbody #'+val.staff_id+'').append('<td>'+val.first_name+'</td>');
					$('table tbody #'+val.staff_id+'').append('<td>'+val.last_name+'</td>');
					$('table tbody #'+val.staff_id+'').append('<td>'+val.username+'</td>');
					$('table tbody #'+val.staff_id+'').append('<td><button id="'+val.staff_id+'" type="button" class="btn btn-default btn-xs">Edit</button></td>')
					.bind('click', function(id){
						//editar pantalla: edito href para pasar id por paramatro.
						window.location.href = "editview/"+val.staff_id;
					});
				});
			},
			error: function(error) {
				alert(error.statusText);
			}
		})	
	}

	init();
})