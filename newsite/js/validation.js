
$.validator.setDefaults({
  submitHandler: function() { alert("submitted!"); }
});

$().ready(function() {

	// validate signup form on keyup and submit
	$("#contactForm").validate({
		rules: {
			name: {
  	    required: true,
        minlength: 2
			},
			email: {
				required: true,
				email: true
			},
			tel: {
				required: true,
			},
			body: "required"
    },
		messages: {
			name: "Please enter your Name",
			email: "Please enter a valid email address",
			tel: "Please enter a valid telephone number",
      body: "Please enter your message"
		}
	});

});
