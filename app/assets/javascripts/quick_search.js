var arrayOfChoices;

function getQuickSearchCountries() {
  var valuesToSubmit = $('#quick-search form').serialize();
  $.ajax({
    url: '/home/country_options_for_quick_search',
    type: 'GET',
    data: valuesToSubmit
  }).success(function(data) {
    $('#resort_id').remove();
    $('#country_id').replaceWith(data);

      if($("#previousValues").val() !== "") {
          arrayOfChoices = JSON.parse($("#previousValues").val());
      } else if(window.ChaletJS && ChaletJS.currentPageCountryID) {
          arrayOfChoices = [ChaletJS.currentPageCountryID, null];
      } else {
          return;
      }

      $('#country_id option').each(function(){
          if(this.value == arrayOfChoices[0]) {
              $('#resort_id').val(arrayOfChoices[0]);
              return false;
          }
      });

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

    if($("#previousValues").val() !== "") {
        arrayOfChoices = JSON.parse($("#previousValues").val());
    } else if(window.ChaletJS && ChaletJS.currentPageResortID) {
        arrayOfChoices = [null, ChaletJS.currentPageResortID];
    } else {
        return;
    }

    $('#resort_id option').each(function(){
        if(this.value == arrayOfChoices[1]) {
            $('#resort_id').val(arrayOfChoices[1]);
            return false;
        }
    });

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

jQuery(function($){

    var elements = ["#country_id", "#resort_id"]; //"#holiday_type_id",
    var quickSearchArray = [];

    $("#quick-search").on("change","select",function(){
        quickSearchArray = [];
        $("#quick-search select.form-control").each(function(i){
            self = this;
            for (var x=0;x<elements.length;x++) {
                if ($(self).is(elements[x])) {
                    quickSearchArray.push($(self).val());
                }
            }
        });
        console.log(JSON.stringify(quickSearchArray));
        $("input[type=hidden]").val(JSON.stringify(quickSearchArray));
    });

});
