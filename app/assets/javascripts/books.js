var book_lookup;

book_lookup = function() {
  $('#book-lookup-form').on('ajax:success', function(event, data, status) {

    $('#book-lookup').replaceWith(data);
    book_lookup();
  });
}

$(document).ready(function() {
  book_lookup();
});
