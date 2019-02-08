$ ->
  pageLoad()

$(document).bind('page:load', ->
  pageLoad()
)

pageLoad = ->
  cycleHeaderImages()
  animateMarker()
  quickSearch()
  galleryZoom()
  activateNavTabs()
  homeCarousel()
  searchFixOnScroll()

cycleHeaderImages = ->
  $('#header-images').cycle({
    fx: 'fade',
    speed: 1500,
    timeout: 3000
  })

animateMarker = ->
  $("#marker").delay(1000).animate({"top":"45px"}, 500, "easeOutBounce")

galleryZoom = ->
  $('#gallery_thumbnails a').featherlight({targetAttr: 'href'})

activateNavTabs = ->
  $('.nav-tabs a').click((e) ->
    e.preventDefault()
    $(this).tab('show')
  )

homeCarousel = ->
  $('#carousel-slides').innerfade({
    speed: 500,
    timeout: 6000,
    containerheight: '528px'
  })

searchFixOnScroll = ->
  $(window).scroll(() ->
    if $(this).scrollTop() > 300
      $('.search-fields').addClass('search-fixed')
    else
      $('.search-fields').removeClass('search-fixed')
  )

window.hideLinksAndSearch = ->
  $('body').addClass('hide-links-and-search')

window.isValidEmailAddress = (emailAddress) ->
  pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
  pattern.test(emailAddress);
