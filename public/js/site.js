function gotoPage() {
  var page = $(this).text();
  window.location = '/explore?page=' + page;
}

function togglePretty() {
  $('#toggle-raw').removeClass('selected');
  $('#toggle-pretty').addClass('selected');

  $('#raw').hide();
  $('#pretty').show();
}

function toggleRaw() {
  $('#toggle-pretty').removeClass('selected');
  $('#toggle-raw').addClass('selected');

  $('#pretty').hide();
  $('#raw').show();
}

function resize() {
  var window = $(this);
  var body = $('body');
  var footer = $('#letterdb-footer');

  if (body.height() < window.height() - footer.height()) {
    footer.css({position: 'absolute', bottom: '0'});
  } else {
    footer.css({position: 'static'});
  }
}

resize();

$(window).on('resize', resize);
$('#toggle-pretty').click(togglePretty);
$('#toggle-raw').click(toggleRaw);
$('#pagination li').click(gotoPage);
