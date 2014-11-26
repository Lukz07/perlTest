$(function(){
	
	var globalJsonData;

	function init(){
		renderPage(1);
	};

	function renderPage(pageNumber){
		$.ajax({
			url: path+'/editdata/'+pageNumber,
			success: function(data){				

				var jsonData= null;
				jsonData = globalJsonData = data.json_data;

				console.log(jsonData);
				
				$('#name').val(jsonData.staff.first_name);
				$('#lastname').val(jsonData.staff.last_name);
				$('#email').val(jsonData.staff.email);

				// for ( i in jsonData.addresses) {
				// 	if (jsonData.addresses[i].address_id == jsonData.customer.address_id){
				// 		$('#adress').val(jsonData.addresses[i].address);
				// 	}
				// };

				// for ( v in jsonData.rented) {
				// 	if (jsonData.rented[v].customer_id == jsonData.customer.customer_id){

				// 		$('table tbody').append('<tr id="'+jsonData.rented[v].rental_id+'"></tr>');
				// 		$('table tbody #'+jsonData.rented[v].rental_id+'').append('<td>'+jsonData.rented[v].rental_id+'</td>');
				// 		$('table tbody #'+jsonData.rented[v].rental_id+'').append('<td>'+jsonData.rented[v].title+'</td>');

				// 	}
				// };
			},
			error: function(data){
				alert(data.responseText);
			}
		})	
	};

	$('.save-btn').on('click', function(e){
		e.preventDefault();
		$.ajax({
			url: path+'/editsave/',
			type: 'POST',
			dataType: 'json',
			data: {
				customer_id : globalJsonData.staff.customer_id,
				store_id : globalJsonData.staff.store_id,
				first_name : $('#name').val(),
				last_name : $('#lastname').val(),
				email : $('#email').val(),
				address_id : $('#address').val(),
				active : globalJsonData.staff.active,
				create_date : globalJsonData.staff.create_date,
				last_update : globalJsonData.staff.last_update
			},
			success: function(data){				

				console.log(data);
				alert("Success!!. Data saved.");
			},
			error: function(error){
				alert(error.statusText);
				console.log(error);
			}
		})
	})

	init();
})