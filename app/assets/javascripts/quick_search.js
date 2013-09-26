function getQuickSearchCountries() {
  var valuesToSubmit = $('#quick-search form').serialize();
  $.ajax({
    url: '/home/country_options_for_quick_search',
    type: 'GET',
    data: valuesToSubmit
  }).success(function(data) {
    $('#resort_id').remove();
    $('#country_id').replaceWith(data);

    if($.cookie('quick_search_country_id') != null) {
      $('#country_id').val($.cookie('quick_search_country_id'));
      $.removeCookie('quick_search_country_id');
    }
    quickSearch();
  });
  return false;
}

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
    $('#holiday_type_id').change(getQuickSearchCountries);  
    $('#country_id').change(getQuickSearchResorts);
    $('#quick-search form').submit(function() {
      if($('#resort_id').val() == '') {
        alert('Please choose a resort first.');
        return false;
      }
    });
    if($('#holiday_type_id').length && $('#holiday_type_id').val() != '') {
      getQuickSearchResorts();
    }
    if($('#country_id').length && $('#country_id').val() != '') {
      getQuickSearchResorts();
    }
  }
}
