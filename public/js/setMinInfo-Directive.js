angular.module('myApp').directive('setMinInfo', [function() {
    return {
	restrict: 'E',
	scope: {
	    info: '='
	},
	templateUrl: 'setMinInfo.html'
    };
  
}]);