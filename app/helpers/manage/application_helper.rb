module Manage
  module ApplicationHelper
    def manage_text_field(form, field, options1 = {}, options2 = { class: 'col-md-4' })
      options1[:class] = "form-control" unless options1[:class]
      tag.div options2 do
        tag.div class: 'form-group' do
          (form.label field) + (form.text_field field, options1)
        end
      end
    end

    def manage_number_field(form, field, options1 = {}, options2 = { class: 'col-md-4' })
      options1[:class] = "form-control" unless options1[:class]
      tag.div options2 do
        tag.div class: 'form-group' do
          (form.label field) + (form.number_field field, options1)
        end
      end
    end

    def manage_text_area_field(form, field, options1 = {}, options2 = { class: 'col-md-4' })
      options1[:class] = "form-control" unless options1[:class]
      tag.div options2 do
        tag.div class: 'form-group' do
          (form.label field) + (form.text_area field, options1)
        end
      end
    end

    def manage_collection_select_field(form, field, collection, value_method, text_method, options1 = {}, options2 = {}, options3 = { class: 'col-md-4' })
      options2[:class] = "form-control select2" unless options2[:class]
      tag.div options3 do
        tag.div class: 'form-group' do
          (form.label field) + (form.collection_select field, collection, value_method, text_method, options1, options2)
        end
      end
    end

    def manage_select_field(form, field, choices, options1 = {}, options2 = {}, options3 = { class: 'col-md-4' })
      options2[:class] = "form-control select2" unless options2[:class]
      tag.div options3 do
        tag.div class: 'form-group' do
          (form.label field) + (form.select field, choices, options1, options2)
        end
      end
    end

    def manage_text_tag(label, name, value, options1 = {}, options2 = { class: 'col-md-4' })
      options1[:class] = "form-control" unless options1[:class]
      tag.div options2 do
        tag.div class: 'form-group' do
          (label_tag label) + (text_field_tag name, value, options1)
        end
      end
    end
  end
end
