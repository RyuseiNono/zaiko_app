require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
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
      expect(page).to have_content(@user.name)
      expect(page).to have_content('ログアウト')
      # 簡単ログイン、新規登録、ログインのボタンが表示されていないことを確認する
      expect(page).to have_no_content('簡単ログイン')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit(root_path)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録アカウント選択ページへ移動する
      visit(entrances_sessions_path)
      # 一般ユーザー新規登録ページへ移動する
      visit(new_user_registration_path)
      # 一般ユーザー情報を入力する
      fill_in('name', with: '')
      fill_in('email', with: '')
      fill_in('password', with: '')
      fill_in('password-confirmation', with: '')
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('button[id="user_registration_submit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end
