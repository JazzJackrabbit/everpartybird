var countdown, handle_ajax_response, party, say, start_party;

$(document).ready(function() {
  var timestamp;
  timestamp = $("#timestamp").val();
  if (timestamp === "now") {
    return start_party();
  } else {
    return window.setTimeout((function() {
      return countdown();
    }), 1000);
  }
});

handle_ajax_response = function(response, success, error) {
  if (typeof response.error === "undefined") {
    return success();
  } else {
    return error();
  }
};

say = function(word) {
  return jQuery.ajax({
    type: "POST",
    url: "/say",
    data: {
      word: word
    },
    success: function(response) {
      return handle_ajax_response(response, (function() {
        return $("#main").html(response);
      }), function() {});
    }
  });
};

party = function() {
  jQuery.ajax({
    type: "POST",
    url: "/party",
    data: {},
    success: function(response) {
      return handle_ajax_response(response, (function() {
        return $("#main").html(response);
      }), function() {});
    }
  });
  return false;
};

start_party = function() {
  $("html").css("background-color", "black");
  return window.setInterval(party, 200);
};

countdown = function() {
  var timestamp;
  timestamp = $("#timestamp").val();
  if (timestamp - 1 === 0) {
    say("Party!");
    return window.setTimeout((function() {
      return start_party();
    }), 500);
  } else {
    say(timestamp - 1);
    $("#timestamp").val(timestamp - 1);
    return window.setTimeout((function() {
      return countdown();
    }), 1000);
  }
};
