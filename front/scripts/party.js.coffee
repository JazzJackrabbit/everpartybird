$(document).ready ->
  timestamp = $("#timestamp").val()
  if timestamp == "now"
    start_party()
  else
    window.setTimeout (->
      countdown()
    ), 1000

handle_ajax_response = (response, success, error) ->
  if typeof response.error is "undefined"
    success()
  else
    error()

say = (word) ->
  jQuery.ajax
    type: "POST"
    url: "/say"
    data:
      word: word
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

start_party = ->
  $("html").css "background-color", "black"
  window.setInterval party, 200

countdown = ->
  timestamp = $("#timestamp").val()
  if timestamp - 1 is 0
    say "Party!"
    window.setTimeout (->
      start_party()
    ), 500
  else
    say timestamp - 1
    $("#timestamp").val timestamp - 1
    window.setTimeout (->
      countdown()
    ), 1000

