Teikei.module("User", function(User, App, Backbone, Marionette, $, _) {

  User.MenuView = Marionette.View.extend({

    el: "#user",

    ui: {
      signInToggle: "#login"
    },

    events: {
      "click #login": "toggleAuth",
      "click #add-farm": "addFarm",
      "click #add-depot": "addDepot"
    },

    initialize: function(controller) {
      this.bindUIElements();
      App.vent.on("user:signin:success", this.onLogin, this);
      App.vent.on("user:logout:success", this.onLogout, this);
    },

    toggleAuth: function(event) {
      event.preventDefault();
      var loggedIn = this.model.get("loggedIn");
      if (!loggedIn) {
        this.trigger("login:selected");
      }
      else {
        this.trigger("logout:selected");
      }
    },

    addFarm: function(event) {
      event.preventDefault();
      App.vent.trigger("user:add:farm");
    },

    addDepot: function(event) {
      event.preventDefault();
      App.vent.trigger("user:add:depot");
    },


    onLogin: function() {
      this.ui.signInToggle.text("Abmelden");
    },

    onLogout: function() {
      this.ui.signInToggle.text("Anmelden");
    }
  });
});
