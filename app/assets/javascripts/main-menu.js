$(() => {

  $('#header-images').partialViewSlider({
    width: 70,
    controls: true,
    controlsPosition: 'inside',
    backdrop: true,
    dots: false,
    transitionSpeed: 1000,
    delay: 5000,
    perspective: true
  });

  $('li.main-menu-item').on('click', function(event){

    const showDropDown = (e) => {
      e.attr('aria-expanded', true);
      e.find('ul').show(300);
    }

    const hideDropDown = (e) => {
      e.attr('aria-expanded', false);
      e.find('ul').hide(200);
    }

    // --- close opened dropdown ----
    hideDropDown($(this).siblings());

    // --- close dropdown on double click ---
    if ($(this).attr('aria-expanded') === 'true') {
      hideDropDown($(this));
    }
    // --- open dropdown on click ---
    else {
     showDropDown($(this));

      // --- close dropdown on click outside ---
      const _this = $(this);

      $(document).mouseup((e) => {

        if(_this.has(e.target).length !== 0){
          return;
        }

        $(document).unbind('mouseup');
        hideDropDown(_this);
      });

    };

  });

  $('ul.main-menu-item-links > li').on('click', () => {
    $(this).parent().hide(200);
  });

});
