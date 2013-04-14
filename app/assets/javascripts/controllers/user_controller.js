Teikei.module("User", function(User, App, Backbone, Marionette, $, _) {

  User.Controller = Backbone.Marionette.Controller.extend({

    initialize: function() {
      this.model = new Teikei.User.Model();
      this.menuView = new Teikei.User.MenuView(this);
      this.loginView = new Teikei.User.LoginView(this);

      this.menuView.bind("login:selected", this.loginPopup, this);
      this.menuView.bind("logout:selected", this.logout, this);
      this.loginView.bind("signInForm:submit", this.signIn, this);
      this.loginView.bind("signUpForm:submit", this.signUp, this);

      App.userPopup.show(this.loginView);
    },

    loginPopup: function() {
      this.loginView.showForm();
      Backbone.history.navigate('login');
    },

    signIn: function(credentials) {
      var model = this.model;
      var loginData = { user: credentials };

      model.save(loginData, {
        success: function(data) {
          App.vent.trigger("user:signin:success");
        },
        error: function(data) {
          App.vent.trigger("user:signin:fail");
        }
      });
    },

    signUp: function(credentials) {
      alert("SignUp not yet implemented.");
    },

    logout: function() {
      var model = this.model;

      model.destroy({
        wait: true,
        success: function(data) {
          model.clear();
          App.vent.trigger("user:logout:success");
        },
        error: function(data) {
          App.vent.trigger("user:logout:fail");
        }
      });
      Backbone.history.navigate('logout');
    }

  });
});
