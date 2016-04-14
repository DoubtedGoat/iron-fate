var app = angular.module('myApp', ['ui.bootstrap']);

//add a controller to it
app.controller('MyCtrl', function($scope, $http) {

$scope.display = false;
   //a scope function to load the data.
   $scope.loadData = function () {
      $http.get('/characters/all').success(function(data) {
         $scope.items = data;
      });
   }; 
$scope.loadData();
});

//TODO: figure out why this cant be moved into a separate file
app.directive('unitBigInfo', [function() {
    var unitBigIController = ['$scope', '$http', function($scope, $http){
	//console.log("inside");

	$scope.unitClicked = function () {
	    $scope.display = !$scope.display;
	};
	
	$scope.loadMoreData = function (shortname) {
		//Loads more speficic data based on shortname, and makes a path to the unit gif
	    $http.get(('/characters/'+ shortname)).success(function(data) {
	      $scope.moreData = data;
		  
		  $scope.gifUnit = (''+$scope.shortname+'_'+($scope.moreData.prepromote||$scope.moreData.base_class)+'');
		  
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


app.directive('setMinInfo', [function() {
    return {
	restrict: 'E',
	scope: {
	    info: '='
	},
	templateUrl: 'setMinInfo.html'
    };
  
}]);

app.directive('setSelector', [function() {
    var setSelController = ['$scope', function($scope){
	$scope.display = false;
	$scope.herro = 'herro?';
	$scope.showModal = function() {
	    $scope.active = true;
	    $scope.herro = 'HERRO!';
	};
	$scope.hideModal = function() {
	    $scope.active = false;
	};
	}];
    return {
	controller: setSelController,
	restrict: 'E',
	scope: {
	    sets: '='
	},
	templateUrl: 'setSelector.html'
    };
  
}]);








