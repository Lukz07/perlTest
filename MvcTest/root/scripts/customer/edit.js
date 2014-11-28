$(function(){
	
	var globalJsonData;

	function init(){
		renderPage(parseInt($(window.location.href.split('/')).last()[0]));
	};

	function renderPage(customer_id){
		$.ajax({
			url: path+'/editdata/'+customer_id,
			success: function(data){				
				var jsonData= null;
				jsonData = globalJsonData = data.json_data;
				
				$('#name').val(jsonData.customer.first_name);
				$('#lastname').val(jsonData.customer.last_name);
				$('#email').val(jsonData.customer.email);

				for ( i in jsonData.addresses) {
					if (jsonData.addresses[i].address_id == jsonData.customer.address_id){
						$('#address').val(jsonData.addresses[i].address);
					}
				};

				for ( v in jsonData.rented) {
					if (jsonData.rented[v].customer_id == jsonData.customer.customer_id){
						$('table tbody').append('<tr id="'+jsonData.rented[v].rental_id+'"></tr>');
						$('table tbody #'+jsonData.rented[v].rental_id+'').append('<td>'+jsonData.rented[v].rental_id+'</td>');
						$('table tbody #'+jsonData.rented[v].rental_id+'').append('<td>'+jsonData.rented[v].title+'</td>');
						$('table tbody #'+jsonData.rented[v].rental_id+'').append('<td>'+jsonData.rented[v].rental_date+'</td>');

					}
				};
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
				customer_id : globalJsonData.customer.customer_id,
				store_id : globalJsonData.customer.store_id,
				first_name : $('#name').val(),
				last_name : $('#lastname').val(),
				email : $('#email').val(),
				addresses : $('#address').val(),
				active : globalJsonData.customer.active,
				create_date : globalJsonData.customer.create_date,
				last_update : globalJsonData.customer.last_update
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