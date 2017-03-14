transitionTime = 400

function getMatchIndex($allMatches, selectedElem) {
  var position = -1;
  for (var i = 0; i < $allMatches.length; i++) {
    if ($allMatches[i] === $t[0]) {
      position = i;
      break;
    }
  }

  return position;
}

function slideMatchesUp(matchesBelow, topOffset, callback) {
  matchesBelow.each(function() {
    $(this).css('position', 'relative');
    $(this).animate({'top': topOffset});
  });

  callback();
}


$(document).ready(function() {

  // $('.potential-match-panel').click(function() {
  $('.decline-btn').click(function() {
    $t = $(this).parents().eq(8);
  
    position = getMatchIndex($('.potential-match-panel'), $t);

    var leftOffset = $('body').width().toString() + 'px';

    $t.css('position', 'relative');

    $t.animate({
      'left': leftOffset,
      'opacity': '0'
    }, transitionTime, function() {

      var $matchesBelow = $($('.potential-match-panel').splice(position + 1));
      var topOffset = '-' + $('.potential-match-panel').height().toString() + 'px';

      slideMatchesUp($matchesBelow, topOffset, function() {
        setTimeout(function() {
          $t.remove();

          $matchesBelow.css({
            'position': '',
            'top': '0'
          });

        }, transitionTime * 3);
      });
    });
  });  

  // $('.potential-match-panel').click(function() {
  $('.accept-btn').click(function() {
    $t = $(this).parents().eq(8);
  
    position = getMatchIndex($('.potential-match-panel'), $t);

    $t.addClass('minimise');

    var $matchesBelow = $($('.potential-match-panel').splice(position + 1));
    var topOffset = '-' + $('.potential-match-panel').height().toString() + 'px';

    slideMatchesUp($matchesBelow, topOffset, function() {
      setTimeout(function() {
        $t.remove();

        $matchesBelow.css({
          'position': '',
          'top': '0'
        });
        
      }, transitionTime * 3);
    });
  });
});