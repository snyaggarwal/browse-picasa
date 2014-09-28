BrowsePicasa = angular.module('BrowsePicasa', ['ngRoute']);

BrowsePicasa.config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
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

//  $httpProvider.interceptors.push('HttpInterceptor'); can configure
}]);