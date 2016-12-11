// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//  require turbolinks
//  require jquery.turbolinks
//= require bootstrap-sprockets
//= require jquery-ui
//= require owl.carousel
//= require bootstrap-modal
//= require bootstrap-modalmanager
//= require_tree .


var hide_spinner = function(){
  $('#spinner').hide();
}

var show_spinner = function(){
  $('#spinner').show();
}

var book_lookup;

book_lookup = function() {
  $('#book-lookup-form').on('ajax:before', function(event, data, status){
    show_spinner();
  });

  $('#book-lookup-form').on('ajax:after',    function(event, data, status){
    hide_spinner();
  });

  $('#book-lookup-form').on('ajax:success', function(event, data, status) {
    $('#book-lookup').replaceWith(data);
    book_lookup();
  });

  $('#book-lookup-form').on('ajax:error', function(event, xhr, status, error){
    hide_spinner();
    $('#book-lookup-results').replaceWith(' ');
    $('#book-lookup-errors').replaceWith('Book was not found.');
  });

}



$(document).ready(function() {
  $(".owl-carousel").owlCarousel();
  book_lookup();
});
