$(function(){
	function init(){
		renderPage(1);
	};

	function renderPage(pageNumber){
		$.ajax({
			url: path+'/editdata/'+pageNumber,
			success: function(data){

				var jsonData= null;
				jsonData = data.json_data;

				console.log(jsonData)

				// $.each(jsonData, function(i, val){
				// 	$('table tbody').append('<tr id="'+i+'"></tr>');
				// 	$('table tbody #'+val.customer_id+'').append('<td>'+val.customer_id+'</td>');
				// 	$('table tbody #'+val.customer_id+'').append('<td>'+val.first_name+'</td>');
				// 	$('table tbody #'+val.customer_id+'').append('<td>'+val.last_name+'</td>');
				// 	$('table tbody #'+val.customer_id+'').append('<td><button id="'+val.customer_id+'" type="button" class="btn btn-default btn-xs">Edit</button></td>');
				// 	$('table tbody #'+val.customer_id+' button').bind('click', function(id){
				// 		id = $(this).attr('id');
						
				// 		//editar pantalla: edito href para pasar id por paramatro.
				// 		window.location.href = "customer/editdata/"+id;
				// 	});
				// });
			},
			error: function(data){
				alert(data.responseText);
			}
		})	
	};

	init();
})