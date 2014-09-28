BrowsePicasa.factory('Notification', function () {
  return {
    log: function(message, type, wait) {
      alertify.log(message, type, wait);
    }
  }
});