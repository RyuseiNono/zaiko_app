import consumer from "./consumer";

consumer.subscriptions.create("ItemChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // debugger;
    // 要素取得
    const items = document.getElementById("items");
    const items_table = document.getElementById("items_table");
    const items_empty = document.getElementById("items_empty");
    // 追加する要素の素材を作成
    const tr = document.createElement("tr");
    const td_name = document.createElement("td");
    const td_count = document.createElement("td");
    const td_Button = document.createElement("td");
    // createElementに商品名、在庫数を代入
    td_name.textContent = data.content.item.name;
    td_count.textContent = data.content.item.count;
    const column = items.appendChild(tr); //itemsにtrを追加
    column.appendChild(td_name); //追加したtrにtd_countを追加
    column.appendChild(td_count); //追加したtrにtd_countを追加
    // 以下ボタンの作成
    td_Button.className = "w-25"; //td_Buttonにクラスを追加
    const Button = column.appendChild(td_Button); //追加したtrにクラスを付与したtd_Buttonを追加
    const addButton = document.createElement("a"); //aタグを作成
    addButton.className = "btn btn-danger"; //addButtonにクラスを追加
    addButton.textContent = "在庫を削除する"; //addButtonに要素を追加
    addButton.href = `/shops/${data.content.item.shop_id}/items/${data.content.item_id}`; //addButtonにhrefを追加
    // アイコン作成
    const addButtonIcon = document.createElement("i");
    addButtonIcon.className = "far fa-trash-alt mx-1";
    Button.appendChild(addButton).appendChild(addButtonIcon);
    if (data.content.items_length == 0) {
      items_table.hidden = true;
      items_empty.hidden = false;
    } else {
      // itemの時、テーブルがhidddenであるため表示させる
      items_table.hidden = false;
      // 追加された時に「商品はまだありません。」を消す
      items_empty.hidden = true;
    }
    // 以下入力欄を空に
    item_name.value = "";
  },
});
