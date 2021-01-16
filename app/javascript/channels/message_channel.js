import consumer from "./consumer";

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $("#messages").prepend(
      `<div id = "message-${data.message.id}"><p><strong>${data.time}${data.message_user_name} : </strong>${data.message.text}</p></div>`
    );
    $("#message-form").val("");
    $("#messages_empty").hide();
    $("#messages_table").show();
    // 最新10件表示のため、オーバーしたら下から削除
    if (data.message_count > 10) {
      $("#messages div:last").remove();
    }
  },
});
