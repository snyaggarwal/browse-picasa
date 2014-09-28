BrowsePicasa = angular.module('BrowsePicasa', ['ngRoute']);

BrowsePicasa.config(['$routeProvider', function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'login.html',
      controller: 'LoginCtrl'
    })
    .when('/albums', {
      templateUrl: 'albums.html',
      controller: 'AlbumsCtrl'
    })
    .when('/albums/:id/photos', {
      templateUrl: 'photos.html',
      controller: 'PhotosCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });
}]);