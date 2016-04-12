angular.module('app')
app.directive('unitBigInfo', [function() {
	return {
	controller: unitBigIController,
	restrict: 'E',
	scope: {
	    shortname: '='
	},
	templateUrl: 'unitBigInfo.html'
    };
	
	
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


    
}]);