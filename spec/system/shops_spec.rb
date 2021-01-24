require 'rails_helper'

RSpec.describe "Shopを登録する", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @shop = FactoryBot.build(:shop)
  end

  context '店舗を新規登録ができるとき' do
    it '正しい情報を入力すれば店舗を新規登録ができて店舗ページに移動する' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @admin.email)
      fill_in('password', with: @admin.password)
      find('button[id=submit_btn]').click
      # 店舗作成ページへのリンクがあることを確認する
      expect(page).to have_link('店舗を作成する')
      # 店舗作成ページへ移動する
      visit(new_shop_path)
      # フォームに情報を入力する
      fill_in('shop[name]', with: @shop.name)
      fill_in('shop[location]', with: @shop.location)
      fill_in('shop[phone_number]', with: @shop.phone_number)
      # 「確認画面へ」を押すと確認画面に移動する
      find('input[name="commit"]').click
      # 「店舗登録」を押すとShopモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Shop.count }.by(1)
      # 店舗画面へ移動し「作成しました」の表示があることを確認する
      expect(page).to have_content("#{@shop.name}を作成しました")
      # トップページへ遷移する
      visit(root_path)
      # 先ほど登作成した内容の店舗が存在することを確認する
      expect(page).to have_content(@shop.name)
    end
  end
  context '店舗を新規登録ができないとき' do
    it '誤った情報を入力すれば店舗を新規登録ができずに新規登録ページに戻ってくる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @admin.email)
      fill_in('password', with: @admin.password)
      find('button[id=submit_btn]').click
      # 店舗作成ページへのリンクがあることを確認する
      expect(page).to have_link('店舗を作成する')
      # 店舗作成ページへ移動する
      visit(new_shop_path)
      # フォームに情報を入力する
      fill_in('shop[name]', with: "")
      fill_in('shop[location]', with: "")
      fill_in('shop[phone_number]', with: "")
      # 「確認画面へ」を押すと入力が誤っていると新規投稿画面に戻りエラーメッセージが出る
      find('input[name="commit"]').click
      expect(page).to have_content('店名を入力してください')
      expect(page).to have_content('住所を入力してください')
      expect(page).to have_content('電話番号を入力してください')
      expect(page).to have_button('確認画面へ')
    end
  end
end

RSpec.describe "Shopを編集する", type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @shop_edit = FactoryBot.build(:shop)
  end

  context '店舗情報を編集できるとき' do
    it '正しい情報を入力すれば店舗を編集ができて店舗ページに移動する' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗ページへ遷移する
      visit(shop_path(@shop))
      # 編集ボタンを押す
      click_on("店舗情報を編集する")
      # フォームに情報を入力して変更ボタンを押す
      fill_in('shop[name]', with: @shop_edit.name)
      fill_in('shop[location]', with: @shop_edit.location)
      fill_in('shop[phone_number]', with: @shop_edit.phone_number)
      click_on("変更")
      # 店舗ページに戻り通知がきているか確認
      expect(current_path).to eq shop_path(@shop)
      expect(page).to have_content("#{@shop_edit.name}を編集しました")
      # 変更された事項が適応されているか確認
      visit(shop_path(@shop))
      expect(page).to have_content(@shop_edit.name)
      expect(page).to have_content(@shop_edit.location)
      expect(page).to have_content(@shop_edit.phone_number)
    end
  end
  context '店舗情報を編集できないとき' do
    it '誤った情報を入力すれば店舗を編集ができずに編集ページに戻ってくる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗ページへ遷移する
      visit(shop_path(@shop))
      # 編集ボタンを押す
      click_on("店舗情報を編集する")
      # フォームに情報を入力して変更ボタンを押す
      fill_in('shop[name]', with: "")
      fill_in('shop[location]', with: "")
      fill_in('shop[phone_number]', with: "")
      click_on("変更")
      #「確認画面へ」を押すと入力が誤っていると新規投稿画面に戻りエラーメッセージが出る
      expect(current_path).to eq shop_path(@shop)
      expect(page).to have_content('店名を入力してください')
      expect(page).to have_content('住所を入力してください')
      expect(page).to have_content('電話番号を入力してください')
    end
  end
end

RSpec.describe "Shopを削除する", type: :system do
  before do
    @shop = FactoryBot.create(:shop)
  end

  context '店舗情報を削除できるとき' do
    it '削除ボタンを押せば削除ができて店舗一覧ページに移動する' do
    # 店舗ユーザでログインする
    visit(new_admin_session_path)
    fill_in('email', with: @shop.admin.email)
    fill_in('password', with: @shop.admin.password)
    find('button[id=submit_btn]').click
    # 店舗ページへ遷移する
    visit(shop_path(@shop))
    # 店舗を削除するを押し、確認画面でOKを選択
    binding.pry
    expect{
      page.accept_confirm do
        click_on("店舗を削除する")
      end
      sleep(0.1)
    }.to change { Shop.count }.by(-1)
    # 通知を確認する
    expect(page).to have_content("#{@shop.name}を削除しました")
    end
  end
end
