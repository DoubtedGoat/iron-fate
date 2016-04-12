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
   
   //need to put this in directive so it applies individually
   
   
$scope.loadData();
});


app.directive('unitBigInfo', [function() {
    var unitBigIController = ['$scope', function($scope){
	$scope.unitClicked = function () {
	    $scope.display = !$scope.display;
	};
	
	$scope.loadMoreData = function (shortname) {
	    /*$http.get(('/characters/'+ shortname)).success(function(data) {
		$scope.moreData = data;
	    });*/
	};
	
	$scope.loadMoreData();
    }];


    return {
	controller: unitBigIController,
	restrict: 'E',
	scope: {
	    shortname: '@'
	},
	templateUrl: 'unitBigInfo.html'
    };
}]);



