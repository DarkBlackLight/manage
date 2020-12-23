module Manage
  module ApplicationHelper
    def render_sidebar(routes)
      (routes.filter { |route| route[:can] }.map do |route|
        route[:children] ?
          ()
          :
          (
            tag.li class: "c-sidebar-nav-item" do
              link_to route[:url], class: "c-sidebar-nav-link" do
                tag.svg class: "c-sidebar-nav-icon" do
                  tag.use "xlink:href": "/manage/svg/free.svg##{route[:icon]}" ""
                end + (route[:name])
              end
            end
          )
      end).inject { |sum, n| sum + n }
    end

    def manage_text_field(form, field, options = {})
      options[:class] = "#{options[:class]} form-control"
      tag.div class: 'form-group' do
        (form.label field) + (form.text_field field, options)
      end
    end

    def manage_number_field(form, field, options = {})
      options[:class] = "#{options[:class]} form-control"
      tag.div class: 'form-group' do
        (form.label field) + (form.number_field field, options)
      end
    end

    def manage_text_area_field(form, field, options = {})
      options[:class] = "#{options[:class]} form-control"
      tag.div class: 'form-group' do
        (form.label field) + (form.text_area field, options)
      end
    end

    def manage_collection_select_field(form, field, collection, value_method, text_method, options = {}, html_options = {})
      html_options[:class] = "#{html_options[:class]} form-control"
      tag.div class: 'form-group' do
        (form.label field) + (form.collection_select field, collection, value_method, text_method, options, html_options)
      end
    end

    def manage_select_field(form, field, choices, options = {}, html_options = {})
      html_options[:class] = "#{html_options[:class]} form-control"
      tag.div class: 'form-group' do
        (form.label field) + (form.select field, choices, options, html_options)
      end
    end

    def manage_text_tag(label, name, value, options = {})
      options[:class] = "form-control" unless options[:class]
      tag.div class: 'form-group' do
        (label_tag label) + (text_field_tag name, value, options)
      end
    end
  end
end
