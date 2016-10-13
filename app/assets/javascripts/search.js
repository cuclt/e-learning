$(document).on('change', '#category_id', function() {
  $('#search').val($('#category_id').val());
  $.get($('#category_search').attr('action'), $('#category_search').serialize(),
    null, 'script');
  return false;
});
$(document).on('keyup', 'input#search', function() {
  $.get($('#admin_search').attr('action'), $('#admin_search').serialize(),
    null, 'script');
  return false;
});
