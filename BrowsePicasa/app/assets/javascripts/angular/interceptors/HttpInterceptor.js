BrowsePicasa.factory('HttpInterceptor', ['$q', 'Notification', function ($q, Notification) {
  return {
    'request': function (config) {
      Notification.log('Loading...');
      return config;
    },

    'requestError': function (rejection) {
      Notification.log('Please try again later.', 'error', 0);
      return $q.reject(rejection);
    },

    'response': function (response) {
      Notification.log('Loaded successfully.', 'success');
      return response;
    },

    'responseError': function (rejection) {
      Notification.log('Please try again later.', 'error', 0);
      return $q.reject(rejection);
    }
  };
}]);