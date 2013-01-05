timerStop = false

$(document).ready ->
  window.setTimeout (->
    countdown()
  ), 1000

handle_ajax_response = (response, success, error) ->
  if typeof response.error is "undefined"
    success()
  else
    error()

say = (word, scale_x) ->
  scale_x = (if typeof scale_x isnt "undefined" then scale_x else 1)
  jQuery.ajax
    type: "POST"
    url: "/say"
    data:
      word: word
      scale_x: scale_x

    success: (response) ->
      handle_ajax_response response, (->
        $("#main").html response
      ), ->


party = ->
  jQuery.ajax
    type: "POST"
    url: "/party"
    data: {}
    success: (response) ->
      handle_ajax_response response, (->
        $("#main").html response
      ), ->
  false

countdown = ->
  if timerStop is false
    timestamp = $("#timestamp").val()
    if timestamp - 1 is 0
      timerStop = true
      say "Party!", "1.5"
      window.setTimeout (->
        $("html").css "background-color", "black"
        window.setInterval party, 200
      ), 500
    else
      say timestamp - 1
      $("#timestamp").val timestamp - 1
      window.setTimeout (->
        countdown()
      ), 1000

