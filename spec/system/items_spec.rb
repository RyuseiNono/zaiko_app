require 'rails_helper'

RSpec.describe 'Itemを登録する', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @item = FactoryBot.build(:item)
  end

  context '在庫を新規登録ができるとき', js: true do
    it '正しい情報を入力すれば在庫を新規登録がでる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗編集ページへ移動し、表示を確認
      visit(shop_path(@shop))
      expect(page).to have_content("商品はありません。")
      # 在庫を編集するを押す
      click_on("在庫を編集する")
      # 追加する商品の情報を入力する
      fill_in('add_item_name', with: @item.name)
      fill_in('add_item_price', with: @item.price)
      fill_in('add_item_count', with: @item.count)
      # 追加を押してItemのカウントが１上がることを確かめる
      expect{
        click_on("追加")
        sleep(0.1)
      }.to change { Item.count }.by(1)
      # 追加した商品の商品名、値段、在庫数が表示されていることを確認する
      expect(page).to have_field 'item[name]', with: "#{@item.name}"
      expect(page).to have_field 'item[price]', with: "#{@item.price}"
      expect(page).to have_field 'item[count]', with: "#{@item.count}"
      expect(page).to have_no_content("商品はありません。")
    end
  end
  context '在庫を新規登録ができないとき' do
    it '誤った情報を入力すれば在庫を新規登録ができない' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗編集ページへ移動する
      visit(shop_path(@shop))
      # 在庫を編集するを押す
      click_on("在庫を編集する")
      # 追加する商品の情報を不備のある状態で入力する
      fill_in('add_item_name', with: "")
      fill_in('add_item_price', with: "")
      fill_in('add_item_count', with: "")
      # 追加を押してもItemのカウントが上がらないことを確かめる
      expect{
        click_on("追加")
        sleep(0.1)
      }.to change { Item.count }.by(0)
    end
  end
end

RSpec.describe 'Itemを編集する', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @item_edit = FactoryBot.build(:item)
  end

  context '在庫情報を編集できるとき' do
    it '正しい情報を入力すれば在庫を編集ができる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @item.shop.admin.email)
      fill_in('password', with: @item.shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗在庫編集ページへ移動する
      visit(new_shop_item_path(@item.shop))
      # 在庫を編集するを押す
      click_on("商品を編集する")
      sleep(0.1)
      # 商品の情報を編集する
      fill_in("item_name_update-##{@item}", with: @item_edit.name)
      fill_in("item_price_update-##{@item}", with: @item_edit.price)
      fill_in("item_count_update-##{@item}", with: @item_edit.count)
      # 編集を保存するを押す
      click_on("編集を保存する")
      sleep(0.1)
      # 編集した内容が表示されているか確認する
      expect(page).to have_field 'item[name]', with: "#{@item_edit.name}"
      expect(page).to have_field 'item[price]', with: "#{@item_edit.price}"
      expect(page).to have_field 'item[count]', with: "#{@item_edit.count}"
      # 「商品を編集する」ボタンが表示されているか確かめる
      expect(page).to have_link("商品を編集する")
    end
  end
  context '在庫情報を編集できないとき' do
    it '誤った情報を入力すれば在庫を編集ができない' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @item.shop.admin.email)
      fill_in('password', with: @item.shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗在庫編集ページへ移動する
      visit(new_shop_item_path(@item.shop))
      # 在庫を編集するを押す
      click_on("商品を編集する")
      sleep(0.1)
      # 商品の誤った情報を編集する
      fill_in("item_name_update-##{@item}", with: "")
      fill_in("item_price_update-##{@item}", with: "")
      fill_in("item_count_update-##{@item}", with: "")
      # 編集を保存するを押す
      click_on("編集を保存する")
      sleep(0.1)
      # 「編集を保存する」ボタンが依然として表示されているか確かめる
      expect(page).to have_button("編集を保存する")
      # 再度、店舗在庫編集ページへ移動する
      visit(new_shop_item_path(@item.shop))
      # 商品が編集前の状態で表示されているか確かめる
      expect(page).to have_field 'item[name]', with: "#{@item.name}"
      expect(page).to have_field 'item[price]', with: "#{@item.price}"
      expect(page).to have_field 'item[count]', with: "#{@item.count}"
    end
  end
end

RSpec.describe 'Itemを削除する', type: :system do
  before { @item = FactoryBot.create(:item) }

  context '在庫情報を削除できるとき' do
    it '削除ボタンを押せば削除ができる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @item.shop.admin.email)
      fill_in('password', with: @item.shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗在庫編集ページへ移動する
      visit(new_shop_item_path(@item.shop))
      # 在庫を削除するを押し、確認画面でOKを選択するとItemのカウントが１減ることを確認
      expect{
        page.accept_confirm do
          click_on("商品を削除する")
        end
        sleep(0.1)
      }.to change { Item.count }.by(-1)
      # 商品はありません。が表示されていることを確認
      expect(page).to have_content("商品はありません。")
    end
  end
end
