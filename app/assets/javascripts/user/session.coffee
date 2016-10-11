# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# @usersessionCtrl = angular.module('usersessionController', []);



# The main contoller logic
@ng_app.controller("UserSessionCtrl", ['$scope', '$interval', '$window', 'NetManager',
($scope, $interval, $window, NetManager)->
    # http://stackoverflow.com/questions/22436501/simple-angularjs-form-is-undefined-in-scope
    # console.log  tmp.form
    $scope.handle_form_submit = ($event, name)->
        # $event.preventDefault();
        # return false
])
