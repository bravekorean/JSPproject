function changeStarColor(starNumber) {
  var stars = document.getElementsByClassName('star');
  var ratingValueInput = document.getElementById('ratingValue');

  // Reset all stars to empty
  for (var i = 0; i < stars.length; i++) {
    stars[i].classList.remove('filled');
  }

  // Fill stars up to the selected star
  for (var i = 0; i < starNumber; i++) {
    stars[i].classList.add('filled');
  }
	console.log("starNumber:", starNumber);
	ratingValueInput.value = starNumber;
}

var imageInput = document.getElementById("imageInput");
var imageContainer = document.getElementById("imageContainer");

imageInput.addEventListener("change", function (event) {
  var file = event.target.files[0];
  var reader = new FileReader();

  reader.onload = function (e) {
    var img = document.createElement("img");
    img.src = e.target.result;
    img.alt = "Selected Image";
    img.style.maxWidth = "100%";
    img.style.maxHeight = "100%";
    
    // Clear the previous image, if any
    imageContainer.innerHTML = "";
    
    // Append the new image to the container
    imageContainer.appendChild(img);
  };

  reader.readAsDataURL(file);
});
