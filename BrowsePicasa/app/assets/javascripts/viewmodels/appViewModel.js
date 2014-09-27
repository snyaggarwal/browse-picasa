function AppViewModel() {
  var self = this;

  self.init = function () {
    self.results = new LoginViewModel();
  };
}