$ = jQuery

$(document).ready ->
  search_games_path = $("#form").data('search-games-path')
  $("#game_name").autocomplete({
    source: (request, response) ->
      $.getJSON search_games_path, { term: request.term }, response
    , minChars: 1,
    max: 40,
    dataType: 'json'
  })
