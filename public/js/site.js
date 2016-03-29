function gotoPage() {
  var page = $(this).text();
  window.location = '/explore?page=' + page;
}

function toggleText() {
  $('#toggle-xml').removeClass('selected');
  $('#toggle-text').addClass('selected');

  $('#letter-xml').hide();
  $('#letter').show();
}

function toggleXML() {
  $('#toggle-text').removeClass('selected');
  $('#toggle-xml').addClass('selected');

  $('#letter').hide();
  $('#letter-xml').show();
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
$('#toggle-text').click(toggleText);
$('#toggle-xml').click(toggleXML);
$('#pagination li').click(gotoPage);
