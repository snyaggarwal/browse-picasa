BrowsePicasa.factory('Login', ['$http', function($http) {
  return {
    create: function(acess_token) {
      return $http.post('/login', {access_token: acess_token}).success(function(response) {
        return response;
      });
    }
  }
}]);