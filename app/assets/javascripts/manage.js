//= require turbolinks
//= require coreui/jquery.min
//= require coreui/jquery-ui.min
//= require rails-ujs
//= require coreui/toastr
//= require coreui/moment.min
//= require coreui/select2.min
//= require coreui/daterangepicker
//= require coreui/full-calendar
//= require coreui/dropzone.min
//= require cocoon
//= require rails_sortable
//= require manage-utils
//= require manage-customize.js


$(document).on('click', '.c-class-toggler', function () {

  var data_target = $($(this).data('target'));
  var data_class = $(this).data('class');

  if (data_target.hasClass(data_class)) {
    data_target.removeClass(data_class)
  } else {
    data_target.addClass(data_class);
  }
})


$(document).on('click', '.c-sidebar-nav-dropdown-toggle', function () {

  var data_target = $($(this).parent());
  var data_class = 'c-show';

  if (data_target.hasClass(data_class)) {
    data_target.removeClass(data_class)
  } else {
    data_target.addClass(data_class);
  }
})

