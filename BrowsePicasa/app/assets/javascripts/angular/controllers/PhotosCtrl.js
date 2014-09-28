BrowsePicasa.controller('PhotosCtrl', ['$scope', '$location', '$routeParams', 'Albums', 'Photos', 'Notification', function($scope, $location, $routeParams, AlbumsService, PhotosService, Notification){
  $scope.init = function() {
    PhotosService.all($routeParams.id).then(function(response) {
      $scope.photos = response.data;
    });
  };

  $scope.postComment = function(photo) {
    PhotosService.comment(photo.album_id, photo.id, photo.comment)
      .then(function(response) {
        Notification.log('Successfully Posted Comment ' + photo.comment + ' on ' + photo.title, 'success');
        photo.comment = '';
      });
  };

  $scope.init();

}]);