$(document).ready(function() {
    $(".punch_in").click(function (event) {
	$password = prompt('Password?');
	$username = $(this).attr('username');
	
	//Need to check for success!
	event.preventDefault();
	punch_in($username, $password);
    });
    
    $('.punch_out').click(function (event) {
	$username = $(this).attr('username');
	$password = prompt('Password?');
	
	//Need to check for success!
	event.preventDefault();
	punch_out($username, $password);
    });
});