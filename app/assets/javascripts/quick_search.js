function getQuickSearchCountries() {
  var valuesToSubmit = $('#quick-search form').serialize();
  $.ajax({
    url: '/home/country_options_for_quick_search',
    type: 'GET',
    data: valuesToSubmit
  }).done(function(data) {
    $('#resort_id').remove();
    $('#country_id').replaceWith(data);

    if($.cookie('quick_search_country_id') != null) {
      $('#country_id').val($.cookie('quick_search_country_id'));
      $.removeCookie('quick_search_country_id');
    }
  });
  return false;
}

function getQuickSearchResorts() {
  var valuesToSubmit = $('#quick-search form').serialize();
  $.ajax({
    url: '/home/resort_options_for_quick_search',
    type: 'GET',
    data: valuesToSubmit
  }).done(function(data) {
    $('#resort_id').replaceWith(data);

    if($.cookie('quick_search_resort_slug') != null) {
      var slug = $.cookie('quick_search_resort_slug');
      $('#resort_id option').each(function(){
        if(this.value == slug) {
          $('#resort_id').val(slug);
          $.removeCookie('quick_search_resort_slug');
          return false;
        }
      });
    }
  });
  return false;
}

function quickSearch() {
  var $qs = $('#quick-search');
  if($qs.length) {
    $qs.on('change', '#holiday_type_id', getQuickSearchCountries);
    $qs.on('change', '#country_id', getQuickSearchResorts);
    $('#quick-search form').submit(function() {
      if($('#resort_id').val() == '') {
        alert('Please choose a resort first.');
        return false;
      }
    });
    if($('#holiday_type_id').length && $('#holiday_type_id').val() != '') {
      getQuickSearchCountries();
    }
    if($('#country_id').length && $('#country_id').val() != '') {
      getQuickSearchResorts();
    }
  }
}
