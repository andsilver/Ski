function getQuickSearchResorts() {
  var valuesToSubmit = $('#quick-search form').serialize();
  $.ajax({
    url: '/home/resort_options_for_quick_search',
    type: 'GET',
    data: valuesToSubmit
  }).success(function(data) {
    $('#resort_id').replaceWith(data);

    if($.cookie('quick_search_resort_id') != null) {
      $('#resort_id').val($.cookie('quick_search_resort_id'));
      $.removeCookie('quick_search_resort_id');
    }
  });
  return false;
}

function quickSearch() {
  if($('#quick-search').length) {    
    $('#country_id').change(getQuickSearchResorts);
    $('#quick-search form').submit(function() {
      if($('#resort_id').val() == '') {
        alert('Please choose a resort first.');
        return false;
      }
    });
    if($('#country_id').length && $('#country_id').val() != '') {
      getQuickSearchResorts();
    }
  }
}
