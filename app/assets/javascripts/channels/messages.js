App.messages = App.cable.subscriptions.create({
    channel: 'MessagesChannel', 
    match_id: $('.chatbox').data('match-id')
  }, 
  {
    received: function(data) {

  }
});

$(document).on('turbolinks:load', function() {
  $('.reply-msg > form').submit(function() {
    var msg = $(this).children('#message_content').val();
    var matchId = $('.chatbox').data('.match-id');
    var userId = $('.chatbox').data('self');

    App.messages.send({content: msg, match_id: matchId, user_id: userId});
    $(this).children('#message_content').val('');

    return false;
  });
});