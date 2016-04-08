var app = angular.module('myApp', []);

//add a controller to it
app.controller('MyCtrl', function($scope, $http) {

$scope.display = false;
   //a scope function to load the data.
   $scope.loadData = function () {
      $http.get('/characters/all').success(function(data) {
         $scope.items = data;
      });
   };
   
   $scope.unitClicked = function () {
	    $scope.display = !$scope.display;
   };
   
$scope.loadData();
});
