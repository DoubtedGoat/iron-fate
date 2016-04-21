angular.module('myApp').directive('unitBigInfo', [unitBigInfoDirective]);

function unitBigInfoDirective(){
	
	return {
	controller: ['$scope', '$http'],
	controllerAs: 'unitBigIController',
	bindToController: true,
	restrict: 'E',
	scope: {
	    shortname: '='
	},
	templateUrl: 'unitBigInfo.html'
    };
	
}
	
    function unitBigIController ($scope, $http){
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
    };


