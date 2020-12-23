module Manage
  class ManageController < ApplicationController
    layout 'manage/application'

    before_action :authenticate_user!

    private

    def routes
      [{
         name: "Dashboard",
         url: url_for({ controller: :dashboard, action: :index }),
         icon: "cil-calendar",
       }]
    end

    def render_sidebar
      routes.map do |route|

        route[:children] ?

          ()
          :
          (
            tag.li class: "c-sidebar-nav-item" do
              link_to routes[:url], class: "c-sidebar-nav-link" do
                tag.svg class: "c-sidebar-nav-icon" do
                  tag.use "xlink:href": "/manage/svg/free.svg##{route[:icon]}"
                end
              end
            end
          )
      end
    end

  end
end
