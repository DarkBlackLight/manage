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

toastr.options = {
  "positionClass": "toast-top-center",
};

$(document).on("click", ".go-back", function (e) {
  window.history.back();
  e.preventDefault();
});

$(document).on("click", ".btn-resource", function (e) {
  form = document.querySelector('.form-resource');
  Rails.fire(form, 'submit');
});

$(document).on('ajax:success', '.form-resource', function (e, data, status, xhr) {
  if (e.originalEvent.detail[0].data)
    window.location.replace(e.originalEvent.detail[0].data);
});

$(document).on('ajax:error', '.form-resource', function (e, data, status, xhr) {
  toastr.error(e.originalEvent.detail[0].data, 'Error!')
});

$(document).on("click", ".btn-cocoon", function (e) {
  var depth = parseInt($(this).data('depth'));
  var ele = $(this);
  for (var i = 0; i < depth; i++)
    ele = ele.parent();

  var target = ele.find($(this).data('cocoon-target'));
  var link = $(this).prev().find('a')
  link.trigger('click');
  target.append($(this).prev().prev());
  initFormComponents();
});

$(document).on('cocoon:after-insert', function () {
  initFormComponents()
});


function initFormComponents() {

  $('.sortable').railsSortable({handle: '.sortable-handle'});

  $('.nested-fields').each(function () {
    if ($(this).next().is('input')) {
      $(this).append($(this).next());
    }
  })

  $(".select2").each(function () {
    if (!$(this).hasClass("select2-container")) {
      $(this).select2({
        theme: 'coreui'
      });
    }
  });

  $('.datepicker').daterangepicker({
    singleDatePicker: true,
    locale: {
      format: "YYYY/MM/DD"
    }
  });

  $('.datetimepicker').daterangepicker({
    singleDatePicker: true,
    timePicker: true,
    timePicker24Hour: true,
    timePickerIncrement: 30,
    locale: {
      format: "YYYY/MM/DD HH:mm"
    }
  });
}


$( document ).on('turbolinks:load', function() {
  initFormComponents();

  var body = $('body');
  window.controller_name = body.data('controller-name');
  window.action_name = body.data('action-name');
  window.resource_id = body.data('resource-id');
});
