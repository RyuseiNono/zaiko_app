require 'rails_helper'

RSpec.describe "Admin新規登録", type: :system do
  before do
    @admin = FactoryBot.build(:admin)
  end

  context '店舗ユーザー新規登録ができるとき' do
    it '正しい情報を入力すれば店舗ユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit(root_path)
      # トップページに新規登録アカウント選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録アカウント選択ページへ移動する
      visit(entrances_sessions_path)
      # 店舗ユーザー新規登録ページへ移動する
      visit(new_admin_registration_path)
      # 店舗ユーザー情報を入力する
      fill_in('name', with: @admin.name)
      fill_in('email', with: @admin.email)
      fill_in('password', with: @admin.password)
      fill_in('password-confirmation', with: @admin.password_confirmation)
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('button[id="admin_registration_submit"]').click
      }.to change { Admin.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ユーザーの名前とログアウトボタンが表示されていることを確認する
      expect(page).to have_link(@admin.name)
      expect(page).to have_link('ログアウト')
      # 簡単ログイン、新規登録、ログインのボタンが表示されていないことを確認する
      expect(page).to have_no_link('簡単ログイン')
      expect(page).to have_no_link('ログイン')
      expect(page).to have_no_link('新規登録')
    end
  end

  context '店舗ユーザー新規登録ができないとき' do
    it '誤った情報では店舗ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit(root_path)
      # トップページに新規登録アカウント選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録アカウント選択ページへ移動する
      visit(entrances_sessions_path)
      # 店舗ユーザー新規登録ページへ移動する
      visit(new_admin_registration_path)
      # 店舗ユーザー情報を入力する
      fill_in('name', with: '')
      fill_in('email', with: 'a@a')
      fill_in('password', with: '')
      fill_in('password-confirmation', with: '')
      # サインアップボタンを押してもadminモデルのカウントは上がらないことを確認する
      expect{
        find('button[id="admin_registration_submit"]').click
      }.to change { Admin.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/admins"
    end
  end
end

RSpec.describe "Adminログイン", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit(root_path)
      # トップページにログインアカウント選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('ログイン')
      # ログインアカウント選択ページへ遷移する
      visit(entrances_sessions_path)
      # 店舗ユーザーログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('店舗ユーザー')
      # 店舗ユーザー新規登録ページへ移動する
      visit(new_admin_session_path)
      # 正しいユーザー情報を入力する
      fill_in('email', with: @admin.email)
      fill_in('password', with: @admin.password)
      # ログインボタンを押す
      find('button[id=submit_btn]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ユーザーの名前とログアウトボタンが表示されていることを確認する
      expect(page).to have_link(@admin.name)
      expect(page).to have_link('ログアウト')
      # 簡単ログイン、新規登録、ログインのボタンが表示されていないことを確認する
      expect(page).to have_no_link('簡単ログイン')
      expect(page).to have_no_link('ログイン')
      expect(page).to have_no_link('新規登録')
    end
  end

  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit(root_path)
      # トップページにログインアカウント選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('ログイン')
      # ログインアカウント選択ページへ遷移する
      visit(entrances_sessions_path)
      # 店舗ユーザーログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('店舗ユーザー')
      # 店舗ユーザー新規登録ページへ移動する
      visit(new_admin_session_path)
      # 正しいユーザー情報を入力する
      fill_in('email', with: 'a@a')
      fill_in('password', with: '')
      # ログインボタンを押す
      find('button[id=submit_btn]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_admin_session_path
    end
  end
end


RSpec.describe "簡単ログイン", type: :system do
  context 'ログインができるとき' do
    it '簡単ログインを押すとゲストユーザーでログインができてトップページに移動する' do
      # トップページに移動する
      visit(root_path)
      # トップページに簡単ログインボタンがあることを確認する
      expect(page).to have_content('簡単ログイン')
      # 簡単ログインボタンを押す
      find('a[id="admins_guest_sign_btn"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ユーザーの名前とログアウトボタンが表示されていることを確認する
      expect(page).to have_link('ゲスト')
      expect(page).to have_link("ログアウト")
      # 簡単ログイン、新規登録、ログインのボタンが表示されていないことを確認する
      expect(page).to have_no_link('簡単ログイン')
      expect(page).to have_no_link('ログイン')
      expect(page).to have_no_link('新規登録')
    end
  end
end
