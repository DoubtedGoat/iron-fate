var app = angular.module('myApp', []);

//add a controller to it
app.controller('MyCtrl', function($scope, $http) {

$scope.display = false;
   //a scope function to load the data.
   $scope.loadData = function () {
      $http.get('/characters/all').success(function(data) {
         $scope.items = data;
		 	console.log("here");

      });
   };
   
   //need to put this in directive so it applies individually
   
   
$scope.loadData();
});

app.directive('unitBigInfo', [function() {
    var unitBigIController = ['$scope', '$http', function($scope, $http){
	console.log("inside");

	$scope.unitClicked = function () {
	    $scope.display = !$scope.display;
	};
	
	$scope.loadMoreData = function (shortname) {
	    $http.get(('/characters/'+ shortname)).success(function(data) {
	      $scope.moreData = data;
	      });
	};
	//TODO: move loadMoreData into a 'service' that is cacheable and is called upon display=true
	$scope.loadMoreData($scope.shortname);
    }];

    return {
	controller: unitBigIController,
	restrict: 'E',
	scope: {
	    shortname: '='
	},
	templateUrl: 'unitBigInfo.html'
    };
  
}]);





