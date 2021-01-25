require 'rails_helper'

RSpec.describe 'Messageを登録する', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @message = FactoryBot.build(:message)
  end

  context 'メッセージを新規登録ができるとき' do
    it '正しい情報を入力すればメッセージを新規登録ができる' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗編集ページへ移動し、表示を確認
      visit(shop_path(@shop))
      # メッセージフォームにメッセージを記入
      fill_in('message-form', with: @message.text)
      # 送信するを押すとMessageのカウントが１増えることを確認する
      expect{
        click_on("送信する")
        sleep(0.1)
      }.to change { Message.count }.by(1)
      # メッセージが表示されているか確認する
      expect(page).to have_content(@message.text)
    end
  end
end
RSpec.describe 'Messageを登録する', type: :system do
  before { @shop = FactoryBot.create(:shop)}
  context 'メッセージを新規登録ができないとき' do
    it '誤った情報を入力すればメッセージを新規登録ができない' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # 店舗編集ページへ移動し、表示を確認
      visit(shop_path(@shop))
      # メッセージフォームに誤ったメッセージを記入
      fill_in('message-form', with: "")
      # 送信するを押すとMessageのカウントが増えないことを確認する
      expect{
        click_on("送信する")
        sleep(0.1)
      }.to change { Message.count }.by(0)
    end
  end
end
