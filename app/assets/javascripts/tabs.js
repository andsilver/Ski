$(document).ready(function() {

  $('#tabs li a:not(:first)').addClass('inactive');
  $('.tab-container').hide();
  $('.tab-container:first').show();

  $('#tabs li a').click(function(){
    var t = $(this).attr('id');
    if($(this).hasClass('inactive')) {
      $('#tabs li a').addClass('inactive');
      $(this).removeClass('inactive');

      $('.tab-container').hide();
      $('#'+ t + 'C').fadeIn('slow');
    }
  });
});
