
$(function(){
	window.onload = (e) => {
		// Get the overlay and image elements
		const overlay = document.getElementById('overlay');
		const image = document.getElementById('image');
  
		// Function to show the overlay and image
		function showImage(url) {
		  image.src = url;
		      // Show the overlay
			  overlay.style.display = 'flex';

		// Add event listeners to close the image
		overlay.addEventListener('click', hideImage);
			document.addEventListener('keydown', hideImageOnEscape);
		}

		// Function to hide the overlay and image
		function hideImage() {
		// Hide the overlay
		overlay.style.display = 'none';
		$.post("https://messy-printer/NUIFocusOff", JSON.stringify({}));
		// Remove event listeners
		overlay.removeEventListener('click', hideImage);
			document.removeEventListener('keydown', hideImageOnEscape);
		}

		// Function to hide the image on escape key press
		function hideImageOnEscape(event) {
			if (event.key === 'Escape') {
			hideImage();
			}
		}
        /* 'links' the js with the Nui message from main.lua */
		window.addEventListener('message', (event) => {
            
			var item = event.data;
			if (item !== undefined && item.type === "open") {
                showImage(item.theurl)
			}
			
		});
	};
});