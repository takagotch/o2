
receive: (data) ->
  $('#chat_messages').append '<div>' + data['user_name'] + ': ' + data['message'] + '</div>'
  ret = data["message"].match(/^\/img(.*))
  if ret?
    $.get 'http://localhost:3001/images/' + ret[1], (ret_api) ->
      $('#chat_messages').append '<img src=' + ret_api['image_path'] + '/>'



