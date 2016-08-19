$(document).on 'turbolinks:load, ready', ->
  $('#coupon').on 'click', ->
    event.preventDefault()
    $('#add_couponModal').modal({backdrop: 'static'})