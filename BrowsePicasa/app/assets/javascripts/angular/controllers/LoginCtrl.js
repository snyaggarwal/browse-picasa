BrowsePicasa.controller('LoginCtrl', ['$scope', '$location', 'Authentication', 'Notification', function($scope, $location, Authentication, Notification){
  $scope.signIn = function(authResult) {
    $scope.$apply(function() {
      $scope.processAuth(authResult);
    });
  };

  $scope.processAuth = function(authResult) {
    $scope.immediateFailed = true;
    if (authResult['access_token']) {
      $scope.immediateFailed = false;
      Authentication.create(authResult['access_token']);
      $location.path('/albums');
    } else if (authResult['error']) {
      if (authResult['error'] == 'immediate_failed') {
        $scope.immediateFailed = true;
      } else {
        Notification.log('Error:' + authResult['error'], 'error', 0);
      }
    }
  };

  $scope.initiateSignIn = function() {
    gapi.auth.signIn({});
  };

  $scope.renderSignIn = function () {
    var additionalParams = {
      'callback': $scope.signIn,
      'theme': 'dark'
    };

    var signinButton = document.getElementById('signinButton');
    signinButton.addEventListener('click', function() {
      gapi.auth.signIn(additionalParams);
    });
  };


  $scope.renderSignIn();

}]);