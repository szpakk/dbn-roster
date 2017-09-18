ROSTERS = {
  legend: function() {
    $('.legend').hide();
    $('.legend-title').on('click', function() {
      $('.legend').toggle();
    })
  },

  selectPlayer: function() {
    $('input:checkbox[id^="players_"]:checked').parent().find('label').addClass('selected')
    $('input:checkbox[id^="players_"]').change(function(){
      if ($(this).is(':checked')) {
        $(this).parent().find('label').addClass('selected'); 
      } else {
        $(this).parent().find('label').removeClass('selected');
      }
   });
  },

  checkboxLimit: function() {
    var selected = $('input:checkbox[id^="players_"]:checked').length
    if (selected > 53) {
      $('.num-selected').addClass('overlimit');
    }
    $('input:checkbox[id^="players_"]').on('change', function() {
      if ($('input:checkbox[id^="players_"]:checked').length < selected) {
        selected--;
      } else {
        selected++;
      }
      $('.num-selected').text(selected + '/53');
      if (selected > 53) {
        $('.num-selected').addClass('overlimit');
      } else {
        $('.num-selected').removeClass('overlimit');
      }
    });
    $('.num-selected').text(selected + '/53');
  },

  main: function() {
    ROSTERS.legend();
    ROSTERS.checkboxLimit();
    ROSTERS.selectPlayer();
  }
}

$(document).on('turbolinks:load', (ROSTERS.main));
