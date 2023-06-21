function validateForm(form) {
  // Get the values entered by the user
  var title = form.title.value;
  var content = form.content.value;
  var ratingValue = form.ratingValue.value;
  var titleArtwork = form.title_artwork.value;
  var imageFile = form.imageFile.value;

  // Get references to the error span elements
  var titleError = document.getElementById("titleError");
  var contentError = document.getElementById("contentError");
  var ratingError = document.getElementById("ratingError");
  var artworkTitleError = document.getElementById("artworkTitleError");

  // Set the initial validity to true
  var isValid = true;

  // Validate the title field
  if (title.trim() === "") {
    titleError.textContent = "Please enter a title.";
    isValid = false;
  } else {
    titleError.textContent = "";
  }

  // Validate the content field
  if (content.trim() === "") {
    contentError.textContent = "Please enter the content.";
    isValid = false;
  } else {
    contentError.textContent = "";
  }

  // Validate the rating field
  if (ratingValue === "") {
    ratingError.textContent = "Please select a rating.";
    isValid = false;
  } else {
    ratingError.textContent = "";
  }

  // Validate the artwork title field
  if (titleArtwork.trim() === "") {
    artworkTitleError.textContent = "Please enter the artwork name.";
    isValid = false;
  } else {
    artworkTitleError.textContent = "";
  }

  // Validate the image file field
  if (imageFile === "") {
    imageFile = "none";
  }

  // If all validations pass, return true to submit the form
  return isValid;
}
