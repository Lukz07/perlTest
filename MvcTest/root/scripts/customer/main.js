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
			url: 'customer/page/'+pageNumber,
			success: function(data){
				var jsonData;
				jsonData = data.json_data;
					
				$.each(jsonData, function(i, val){
					$('table tbody').append('<tr id="'+i+'"></tr>');
					$('table tbody #'+i+'').append('<td>'+val.customer_id+'</td>');
					$('table tbody #'+i+'').append('<td>'+val.first_name+'</td>');
					$('table tbody #'+i+'').append('<td>'+val.last_name+'</td>');
					$('table tbody #'+i+'').append('<td><button type="button" class="btn btn-default btn-xs">Edit</button></td>');
				});
			}
		})	
	}

	init();
})