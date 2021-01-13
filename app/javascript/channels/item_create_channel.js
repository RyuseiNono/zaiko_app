import consumer from "./consumer";

consumer.subscriptions.create("ItemCreateChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const item = data.content.item;
    // 要素取得
    const items = document.getElementById("items");
    const clone_new = document.getElementById("item-#clone_new");
    const clone_index = document.getElementById("item-#clone_index");
    const items_table = document.getElementById("items_table");
    const items_empty = document.getElementById("items_empty");
    // new
    if (clone_new != null) {
      // ノード定義
      var new_item = clone_new.cloneNode(true);
      var new_item_tr = new_item;
      var new_item_form = new_item.getElementsByTagName("form")[0];
      var new_item_input_name = new_item.getElementsByTagName("input")[1];
      var new_item_input_price = new_item.getElementsByTagName("input")[2];
      var new_item_input_count = new_item.getElementsByTagName("input")[3];
      var new_item_button_update = new_item.getElementsByTagName("button")[0];
      var new_item_button_delete = new_item.getElementsByTagName("a")[0];

      // フォーム構築
      new_item.hidden = false;
      new_item_tr.id = `item-#${item.id}`;
      new_item_form.id = `form-#${item.id}`;
      new_item_form.action = `/shops/${item.shop_id}/items/${item.id}`;
      new_item_input_name.value = item.name;
      new_item_input_name.id = `item_name_new-#${item.id}`;
      new_item_input_name.setAttribute("form", `form-#${item.id}`);
      new_item_input_name.name = "item[name]";
      new_item_input_price.value = item.price;
      new_item_input_price.id = `item_price_new-#${item.id}`;
      new_item_input_price.setAttribute("form", `form-#${item.id}`);
      new_item_input_price.name = "item[name]";
      new_item_input_count.value = item.count;
      new_item_input_count.id = `item_count_new-#${item.id}`;
      new_item_input_count.setAttribute("form", `form-#${item.id}`);
      new_item_input_count.name = "item[count]";
      new_item_button_update.setAttribute("form", `form-#${item.id}`);
      new_item_button_delete.href = `/shops/${item.shop_id}/items/${item.id}`;
      items.appendChild(new_item);

      // 入力欄消去
      const add_item_name = document.getElementById("add_item_name");
      const add_item_price = document.getElementById("add_item_price");
      const add_item_count = document.getElementById("add_item_count");
      add_item_name.value = "";
      add_item_price.value = "";
      add_item_count.value = 1;
    }
    // index
    if (clone_index != null) {
      // ノード定義
      var new_item = clone_index.cloneNode(true);
      var new_item_tr = new_item;
      var new_item_name = new_item.getElementsByTagName("td")[0];
      var new_item_price = new_item.getElementsByTagName("td")[1];
      var new_item_count = new_item.getElementsByTagName("td")[2];

      // 構築
      new_item.hidden = false;
      new_item_tr.id = `item-#${item.id}`;
      new_item_name.textContent = item.name;
      new_item_price.textContent = `${item.price}円`;
      new_item_count.textContent = item.count;
      items.appendChild(new_item);

      // countが0の時の処理
      if (item.count == 0) {
        new_item_name.classList.add("text-muted");
        new_item_price.classList.add("text-muted");
        new_item_count.classList.add("text-muted");
      }
    }

    //itemの数による処理
    if (data.content.items_length == 0) {
      items_table.hidden = true;
      items_empty.hidden = false;
    } else {
      // itemの時、テーブルがhidddenであるため表示させる
      items_table.hidden = false;
      // 追加された時に「商品はまだありません。」を消す
      items_empty.hidden = true;
    }

    // ボタン構築

    // // 入力欄消去
    // const add_item_name = document.getElementById("add_item_name");
    // add_item_name.value = "";

    // // debugger;
    // // 要素取得
    // const items = document.getElementById("items");
    // const items_table = document.getElementById("items_table");
    // const items_empty = document.getElementById("items_empty");
    // const add_item_name = document.getElementById("add_item_name");
    // // 追加する要素の素材を作成
    // var tr = document.createElement("tr");
    // var td_name = document.createElement("td");
    // var input_name = document.createElement("input");
    // var td_count = document.createElement("td");
    // var input_count = document.createElement("input");
    // var td_Button = document.createElement("td");
    // // id追加
    // tr.id = `item-#${data.content.item.id}`;
    // // createElementに商品名、在庫数を代入
    // input_count.value = data.content.item.count;
    // td_count.appendChild(input_count);
    // input_count.value = data.content.item.name;
    // td_name.appendChild(input_name);
    // // if (data.content.item.count >= 1) {
    // //   td_name.textContent = data.content.item.name;
    // // } else if (data.content.item.count == 0) {
    // //   const del = document.createElement("del");
    // //   del.textContent = data.content.item.name;
    // //   td_name.appendChild(del);
    // //   td_name.className = "text-muted";
    // //   td_count.className = "text-muted";
    // // }
    // const column = items.appendChild(tr); //itemsにtrを追加
    // column.appendChild(td_name); //追加したtrにtd_countを追加
    // column.appendChild(td_count); //追加したtrにtd_countを追加
    // // 以下ボタンの作成
    // td_Button.className = "w-25"; //td_Buttonにクラスを追加
    // const Button = column.appendChild(td_Button); //追加したtrにクラスを付与したtd_Buttonを追加
    // const addButton = document.createElement("a"); //aタグを作成
    // addButton.className = "btn btn-danger"; //addButtonにクラスを追加
    // addButton.textContent = "在庫を削除する"; //addButtonに要素を追加
    // addButton.href = `/shops/${data.content.item.shop_id}/items/${data.content.item.id}`; //addButtonにhrefを追加
    // addButton.dataset.confirm = "この作業は戻せません。本当に削除しますか?"; //addButtonにdata-confirmを追加
    // addButton.dataset.method = "delete"; //addButtonにdata-methodを追加
    // addButton.dataset.remote = "true"; //addButtonにdata-remoteを追加
    // // アイコン作成
    // const addButtonIcon = document.createElement("i");
    // addButtonIcon.className = "far fa-trash-alt mx-1";
    // Button.appendChild(addButton).appendChild(addButtonIcon);
    // if (data.content.items_length == 0) {
    //   items_table.hidden = true;
    //   items_empty.hidden = false;
    // } else {
    //   // itemの時、テーブルがhidddenであるため表示させる
    //   items_table.hidden = false;
    //   // 追加された時に「商品はまだありません。」を消す
    //   items_empty.hidden = true;
    // }
    // // 以下入力欄を空に
    // add_item_name.value = "";
  },
});
