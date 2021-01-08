import consumer from "./consumer";

consumer.subscriptions.create("ItemCreateChannel", {
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
    const add_item_name = document.getElementById("add_item_name");
    // 追加する要素の素材を作成
    var tr = document.createElement("tr");
    var td_name = document.createElement("td");
    var td_count = document.createElement("td");
    var td_Button = document.createElement("td");
    // id追加
    tr.id = `item-#${data.content.item.id}`;
    // createElementに商品名、在庫数を代入
    td_count.textContent = data.content.item.count;
    if (data.content.item.count >= 1) {
      td_name.textContent = data.content.item.name;
    } else if (data.content.item.count == 0) {
      const del = document.createElement("del");
      del.textContent = data.content.item.name;
      td_name.appendChild(del);
      td_name.className = "text-muted";
      td_count.className = "text-muted";
    }
    const column = items.appendChild(tr); //itemsにtrを追加
    column.appendChild(td_name); //追加したtrにtd_countを追加
    column.appendChild(td_count); //追加したtrにtd_countを追加
    // 以下ボタンの作成
    td_Button.className = "w-25"; //td_Buttonにクラスを追加
    const Button = column.appendChild(td_Button); //追加したtrにクラスを付与したtd_Buttonを追加
    const addButton = document.createElement("a"); //aタグを作成
    addButton.className = "btn btn-danger"; //addButtonにクラスを追加
    addButton.textContent = "在庫を削除する"; //addButtonに要素を追加
    addButton.href = `/shops/${data.content.item.shop_id}/items/${data.content.item.id}`; //addButtonにhrefを追加
    addButton.dataset.confirm = "この作業は戻せません。本当に削除しますか?"; //addButtonにdata-confirmを追加
    addButton.dataset.method = "delete"; //addButtonにdata-methodを追加
    addButton.dataset.remote = "true"; //addButtonにdata-remoteを追加
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
    add_item_name.value = "";
  },
});
