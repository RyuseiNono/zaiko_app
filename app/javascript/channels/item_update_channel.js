import consumer from "./consumer";

consumer.subscriptions.create("ItemUpdateChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const item = data.content.item;
    const clone_new = document.getElementById("item-#clone_new");
    const clone_index = document.getElementById("item-#clone_index");
    const update_item = document.getElementById(`item-#${item.id}`);

    if (clone_new != null) {
      var item_name_new = document.getElementById(`item_name_new-#${item.id}`);
      var item_count_new = document.getElementById(
        `item_count_new-#${item.id}`
      );

      item_name_new.value = `${item.name}`;
      item_count_new.value = `${item.count}`;
    } else if (clone_index != null) {
      var item_name_index = document.getElementById(
        `item_name_index-#${item.id}`
      );
      var item_count_index = document.getElementById(
        `item_count_index-#${item.id}`
      );
      item_name_index.textContent = item.name;
      item_count_index.textContent = item.count;

      // countによる処理
      var new_item_name = update_item.getElementsByTagName("td")[0];
      var new_item_count = update_item.getElementsByTagName("td")[1];
      if (item.count == 0) {
        new_item_name.classList.add("text-muted");
        new_item_count.classList.add("text-muted");
      } else {
        new_item_name.classList.remove("text-muted");
        new_item_count.classList.remove("text-muted");
      }
    }
  },
});
