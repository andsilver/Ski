$(() => {

  function setDropDown() {
    
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
  }

  $('li.main-menu-item').on('click', setDropDown);

  $('#drop_down').on('click', setDropDown);

  $('ul.main-menu-item-links > li').on('click', () => {
    $(this).parent().hide(200);
  });

});
