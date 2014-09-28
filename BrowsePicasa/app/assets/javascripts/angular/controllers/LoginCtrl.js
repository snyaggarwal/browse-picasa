BrowsePicasa.controller('LoginCtrl', ['$scope', '$location', 'Login', function($scope, $location, LoginService){
  $scope.signIn = function(authResult) {
    $scope.$apply(function() {
      $scope.processAuth(authResult);
    });
  };

  $scope.processAuth = function(authResult) {
    $scope.immediateFailed = true;
    if (authResult['access_token']) {
      $scope.immediateFailed = false;
      LoginService.create(authResult['access_token']);
      $location.path('/albums');
    } else if (authResult['error']) {
      if (authResult['error'] == 'immediate_failed') {
        $scope.immediateFailed = true;
      } else {
        console.log('Error:' + authResult['error']);
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