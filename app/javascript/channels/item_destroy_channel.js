import consumer from "./consumer";

consumer.subscriptions.create("ItemDestroyChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // debugger;
    const item = document.getElementById(`item-#${data.content.item.id}`);
    item.remove();
    if (data.content.items_length == 0) {
      items_table.hidden = true;
      items_empty.hidden = false;
    } else {
      // itemの時、テーブルがhidddenであるため表示させる
      items_table.hidden = false;
      // 追加された時に「商品はまだありません。」を消す
      items_empty.hidden = true;
    }
  },
});
