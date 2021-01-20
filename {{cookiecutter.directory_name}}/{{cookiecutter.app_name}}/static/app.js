window.onload=function() {
	
	function handleForm(e) {
		if (e.preventDefault) e.preventDefault();

		var params = {
			id: document.getElementById('input-id').value
		}

		fetch("/api/person?" + new URLSearchParams(params))
		.then(res => {
			let box = document.getElementById('response-box');
			res.json().then(data => {
				if (data["error"]) {
					box.innerHTML = "Error: " + data["error"];
				} else if (data["name"]) {
					box.innerHTML = "Person name is " + data["name"];
				} else {
					box.innerHTML = "Person not found.";
				}
			});
		})
	}

	var form = document.getElementById('main-form');
	if (form.attachEvent) {
	    form.attachEvent("submit", handleForm);
	} else {
	    form.addEventListener("submit", handleForm);
	}
}