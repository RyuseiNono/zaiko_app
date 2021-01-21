require 'rails_helper'

RSpec.describe "User新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context '一般ユーザー新規登録ができるとき' do
    it '正しい情報を入力すれば一般ユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録アカウント選択ページへ移動する
      visit(entrances_sessions_path)
      # 一般ユーザー新規登録ページへ移動する
      visit(new_user_registration_path)
      # 一般ユーザー情報を入力する
      fill_in('name', with: @user.name)
      fill_in('email', with: @user.email)
      fill_in('password', with: @user.password)
      fill_in('password-confirmation', with: @user.password_confirmation)
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('button[id="user_registration_submit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ユーザーの名前とログアウトボタンが表示されていることを確認する
      expect(page).to have_link(@user.name)
      expect(page).to have_link('ログアウト')
      # 簡単ログイン、新規登録、ログインのボタンが表示されていないことを確認する
      expect(page).to have_no_link('簡単ログイン')
      expect(page).to have_no_link('ログイン')
      expect(page).to have_no_link('新規登録')
    end
  end

  context '一般ユーザー新規登録ができないとき' do
    it '誤った情報では一般ユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_link('新規登録')
      # 新規登録アカウント選択ページへ移動する
      visit(entrances_sessions_path)
      # 一般ユーザー新規登録ページへ移動する
      visit(new_user_registration_path)
      # 一般ユーザー情報を入力する
      fill_in('name', with: '')
      fill_in('email', with: 'a@a')
      fill_in('password', with: '')
      fill_in('password-confirmation', with: '')
      # サインアップボタンを押してもuserモデルのカウントは上がらないことを確認する
      expect{
        find('button[id="user_registration_submit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "Userログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit(root_path)
      # トップページにログインアカウント選択ページへ遷移するボタンがあることを確認する
      expect(page).to have_link('ログイン')
      # ログインアカウント選択ページへ遷移する
      visit(entrances_sessions_path)
      # 一般ユーザーログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('一般ユーザー')
      # 一般ユーザー新規登録ページへ移動する
      visit(new_user_session_path)
      # 正しいユーザー情報を入力する
      fill_in('email', with: @user.email)
      fill_in('password', with: @user.password)
      # ログインボタンを押す
      find('button[id=submit_btn]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ユーザーの名前とログアウトボタンが表示されていることを確認する
      expect(page).to have_link(@user.name)
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
      # 一般ユーザーログインページへ遷移するボタンがあることを確認する
      expect(page).to have_link('一般ユーザー')
      # 一般ユーザー新規登録ページへ移動する
      visit(new_user_session_path)
      # 正しいユーザー情報を入力する
      fill_in('email', with: 'a@a')
      fill_in('password', with: '')
      # ログインボタンを押す
      find('button[id=submit_btn]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
