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

cycleHeaderImages = ->
  $('#header-images').cycle({
    fx: 'fade',
    speed: 1500,
    timeout: 3000
  })

animateMarker = ->
  $("#marker").delay(1000).animate({"top":"45px"}, 500, "easeOutBounce")

galleryZoom = ->
  $('#gallery_thumbnails a').fancyZoom({scaleImg: true, closeOnClick: true})

activateNavTabs = ->
  $('.nav-tabs a').click( ->
    e.preventDefault()
    $(this).tab('show')
  )
