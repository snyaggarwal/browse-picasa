/*global $ */

var HttpService = (function () {
  var showLoader = function ($el) {
      $el.attr('disabled', 'disabled').addClass('is-loading');
    },

    hideLoader = function ($el) {
      $el.removeAttr('disabled').removeClass('is-loading');
    },

    showError = function () {
      appViewModel.header.errorVisible(true);
    },

    call = function (config, $el) {
      config.beforeSend = function () {
        if (config.clearError) {
          appViewModel.header.errorVisible(false);
        }
        if ($el) {
          showLoader($el);
        }
      };

      var completeCallback = config.complete;
      config.complete = function () {
        if ($el) {
          hideLoader($el);
        }
        if (completeCallback) {
          completeCallback();
        }
      };

      config.error = function (error) {
        if (error.status === 500)
          showError();
        if (config.errorCallback)
          config.errorCallback(error);
      };
      $.ajax(config);
    },

    get = function (url, successCallback, $el, clearError) {
      var clear = clearError == undefined ? true : clearError;
      call({url: url, success: successCallback, clearError: clear}, $el);
    },

    post = function (url, data, successCallback, clearError, errorCallback, completeCallback) {
      var clear = clearError == undefined ? true : clearError;
      call({type: "POST", contentType: 'application/json', url: url, success: successCallback, clearError: clear,
        data: JSON.stringify(data), errorCallback: errorCallback, complete: completeCallback});
    };

  return {
    get: get,
    post: post,
    showError: showError
  };
})();