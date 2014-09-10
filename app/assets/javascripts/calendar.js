function calendarControls() {
  $('#later').click(function() {
    if($('.month:visible').last().next('.month').length) {
      a = $('.month:visible').last().next('.month');
      b = a.next();
      c = b.next();
      $('.month:visible').hide();
      a.show();
      b.show();
      c.show();
    }
    return false;
  });

  $('#earlier').click(function() {
    if($('.month:visible').first().prev('.month').length) {
      a = $('.month:visible').first().prev('.month');
      b = a.prev();
      c = b.prev();
      $('.month:visible').hide();
      a.show();
      b.show();
      c.show();
    }
    return false;
  });
}
