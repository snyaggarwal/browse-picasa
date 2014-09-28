BrowsePicasa.factory('Authentication', ['$http', function ($http) {
  return {
    create: function (acess_token) {
      return $http.post('/login', {access_token: acess_token}).success(function (response) {
        return response;
      });
    },

    disconnect: function () {
      return $http.delete("/logout",
        {
          headers: {'X-CSRF-Token': $($('meta[name=csrf-token]')[0]).attr('content')}
        }
      );
    }
  }
}]);