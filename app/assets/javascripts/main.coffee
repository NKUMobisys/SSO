# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# The main contoller logic
@ng_app.controller("MainCtrl", ['$scope', '$interval', '$window', 'NetManager',
($scope, $interval, $window, NetManager)->
	console.log 123
])
