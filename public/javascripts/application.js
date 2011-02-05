$(document).ready(function() {
  $('#pastes_open').bind('click', function(event) {
    $('#pastes').slideToggle();
    $('#instructions').slideUp();
  });
  $('#creds').bind('click', function(event) {
    $('#instructions').slideDown();
    $('#pastes').slideUp();
  });
  $('#instructions_open').bind('click', function(event) {
    $('#instructions').slideToggle();
    $('#pastes').slideUp();
  });
  $('#curl_open').bind('click', function(event) {
    $('#curl').slideToggle();
    $('#ruby').slideUp();
    $('#bash').slideUp();
  });
  $('#ruby_open').bind('click', function(event) {
    $('#ruby').slideToggle();
    $('#bash').slideUp();
    $('#curl').slideUp();
  });
  $('#bash_open').bind('click', function(event) {
    $('#bash').slideToggle();
    $('#ruby').slideUp();
    $('#curl').slideUp();
  });
});

