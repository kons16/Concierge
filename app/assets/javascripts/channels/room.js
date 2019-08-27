App.room = App.cable.subscriptions.create("RoomChannel", {
    connected: function () {

    },

    disconnected: function () {

    },

    received: function (data) {
        return $('#chat-index').append('<li>' + data.message + '</li>');
    },

    speak: function (message) {
        return this.perform('speak', {message: message});
    }
}, $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if(event.keyCode == 13) {
        var chatForm = $('#chat-form');
        App.chat.speak(chatForm.val());
        return
    }

}));