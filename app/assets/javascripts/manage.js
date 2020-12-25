//= require rails-ujs
//= require coreui/coreui.bundle.min.js
//= require coreui/svgxuse.min
//= require coreui/coreui-chartjs.bundle
//= require coreui/coreui-utils
//= require coreui/jquery.min
//= require coreui/toastr
//= require coreui/moment.min
//= require coreui/select2.min
//= require coreui/daterangepicker
//= require coreui/full-calendar
//= require cocoon
//= require customize_manage

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

$(document).on('cocoon:after-insert', function () {
  initFormComponents()
});

$(document).ready(function () {
  initFormComponents()
});


function initFormComponents() {

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