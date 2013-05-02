$(document).ready(function() {
    $('.password').click(function(event){
	if(prompt('Password?') == '') {}
	else {
	    alert('INTRUDER!!! INTRUDER ALERT!!! FACTORY WILL SELF-DESTRUCT IN 5...');
	    alert('4...');
	    alert('3...');
	    alert('2...');
	    alert('1...');
	    alert('lol jk');
	    event.preventDefault();
	}
    });
});