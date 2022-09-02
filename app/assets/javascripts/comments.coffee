# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# $(document).ready ->
#   Rails.ajax({
#   url: "",
#   type: "get",
#   data: "",
#   success: function(data) {},
#   error: function(data) {}
#   })


get_comment_likes_by = (id) ->
  Rails.ajax({
  url: "comment/likes/"+id,
  type: "get",
  success: (data)->
    console.log data
  ,
  error: (data)-> {}
  })
