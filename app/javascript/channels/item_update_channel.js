import consumer from "./consumer";

consumer.subscriptions.create("ItemUpdateChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var item_name_new = document.getElementById(
      `item_name_new-#${data.content.item.id}`
    );
    var item_count_new = document.getElementById(
      `item_count_new-#${data.content.item.id}`
    );
    var item_name_index = document.getElementById(
      `item_name_index-#${data.content.item.id}`
    );
    var item_count_index = document.getElementById(
      `item_count_index-#${data.content.item.id}`
    );

    if (item_name_new != null) {
      item_name_new.value = `${data.content.item.name}`;
    }
    if (item_count_new != null) {
      item_count_new.value = `${data.content.item.count}`;
    }
    if (item_name_index != null) {
      item_name_index.textContent = data.content.item.name;
    }
    if (item_count_index != null) {
      item_count_index.textContent = data.content.item.count;
    }
  },
});
