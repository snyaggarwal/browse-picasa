BrowsePicasa.directive('logout', ['$location', 'Authentication', function($location, Authentication) {
  return function(scope, element, attrs) {
    var clickingCallback = function() {
      Authentication.disconnect().then(function(response) {
        console.log(response);
        $location.path('/');
      });
    };
    element.bind('click', clickingCallback);
  }
}]);