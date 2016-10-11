# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

<% ctrl_name = name.singularize.gsub("::", "") %>


@ng_app.controller("<%= ctrl_name %>Ctrl", ['$scope', '$interval', '$window', 'NetManager',
($scope, $interval, $window, NetManager)->
    # Here the controller code
    
])
