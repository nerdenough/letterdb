$(function () {
  resize();
});

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

$(window).on('resize', resize);
