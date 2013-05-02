/**
 * @author Eric L
 *
 *  Timeclock API example:
 * 
 * 	Using this api, you can clock a user in or out; you can fetch all of the elves 
 * 	including their username, displayname and whether they are signed in or not; you can also
 *  individually fetch the punch status of a user. 
 * 
 * 	All operations cant be accomplished via GET http calls. All operations take atleast 
 * 	one GET parameter: operation  they may also require username and/or password.
 * 
 * 	Each operation returns json including a status value that is 0 upon success and 1 upon failure.
 * 	When a failure has occured (status == 1), check the status_text value for a description. 
 * 
 * Format:
 * 		Punch in:
 * 			API_URL+"?operation=100&username=<<username>>&password=<<password>>";
 * 
 * 		Punch out:
 * 			API_URL+"?operation=101&username=<<username>>&password=<<password>>";
 * 
 * 		Fetch Elves:
 * 			API_URL+"?operation=102";
 * 
 * 		Fetch In/Out Status:
 * 			API_URL+"?operation=103&username=<<username>>"
 * 
 * 		 *Replace all <<values>>  
 */

//Operations
var PUNCH_IN = 100;
var PUNCH_OUT = 101;
var FETCH_ELVES = 102;
var IN_OUT_STATE = 103;
var API_URL = "http://10.1.10.78/timeclock/timeclock_api.php";

//Return values
var SUCCESS = 0;
var FAILURE = 1;
	
function punch_in(user_name, password)
{
    var url = API_URL + "?"+"operation="+PUNCH_IN+"&username="+user_name+"&password="+password;
    $.ajax({
	dataType: "json",
	url: url,
	success: function(json_data)
	{
	    if(json_data.status == SUCCESS)
	    {
		in_out_state(user_name);
	    }
	    else if(json_data.status == FAILURE){
		console.debug(json_data.status_text);
	    }
	    else
	    {
		console.debug("Punching in failed unexpectedly.");
	    }
	}
    });
}
function punch_out(user_name, password)
{
    var url = API_URL + "?"+"operation="+PUNCH_OUT+"&username="+user_name+"&password="+password;
    $.ajax({
	dataType: "json",
	url: url,
	success: function(json_data)
	{
	    if(json_data.status == SUCCESS)
	    {
		in_out_state(user_name);
	    }
	    else if(json_data.status == FAILURE){
		console.debug(json_data.status_text);
	    }
	    else
	    {
		console.debug("Punching out failed unexpectedly.");
	    }
	}
    });
}
function fetch_elves()
{
    var url = API_URL + "?"+"operation="+FETCH_ELVES;
    $.ajax({
	dataType: "json",
	url: url,
	success: function(json_data)
	{
	    if(json_data.status == SUCCESS)
	    {							
		$.each( json_data, function( user_name, user_data ) {
		    if(user_name != 'status')
		    {
			console.debug("User name: "+user_name+", display name: "+user_data.display_name+", in/out state: "+user_data.state)
		    }
		});
	    }
	    else if(json_data.status == FAILURE){
		console.debug(json_data.status_text);
	    }
	    else
	    {
		console.debug("Fetching elves failed unexpectedly.");
	    }
	}
    });
}
function in_out_state(username)
{
    var url = API_URL + "?"+"operation="+IN_OUT_STATE+"&username="+username;
    $.ajax({
	dataType: "json",
	url: url,
	success: function(json_data)
	{
	    if(json_data.status == SUCCESS)
	    {
		console.debug(username+" is logged "+json_data.state);
	    }
	    else if(json_data.status == FAILURE){
		console.debug(json_data.status_text);
	    }
	    else
	    {
		console.debug("Fetching in/out state failed unexpectedly.");
	    }
	}
    });
    
}