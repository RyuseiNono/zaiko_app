require 'rails_helper'

RSpec.describe 'Favoriteを登録、削除する', type: :system do
  before { @shop = FactoryBot.create(:shop) }
  context 'お気に入りを登録、削除するとき' do
    it 'ハートマークを押せばお気に入り登録ができてお気に入りページに追加され、再度押せば解除される' do
      # 店舗ユーザでログインする
      visit(new_admin_session_path)
      fill_in('email', with: @shop.admin.email)
      fill_in('password', with: @shop.admin.password)
      find('button[id=submit_btn]').click
      # お気に入りボタンを押すとFavoriteのカウントが１上がることを確認する
      expect{
        click_link(nil, href: shop_favorites_path(@shop))
        sleep(0.1)
      }.to change { Favorite.count }.by(1)
      # お気に入り一覧を表示する
      visit(favorites_path)
      # お気に入りに登録した店舗が表示されていることを確認する
      expect(page).to have_content(@shop.name)
      # 店舗一覧へ戻る
      visit(new_admin_session_path)
      # お気に入りボタンを押すとFavoriteのカウントが１下がることを確認する
      expect{
        click_link(nil, href: shop_favorite_path(@shop,@shop.admin))
        sleep(0.1)
      }.to change { Favorite.count }.by(-1)
      # お気に入り一覧を表示する
      visit(favorites_path)
      # お気に入り解除した店舗が表示されていないことを確認する
      expect(page).to have_no_content(@shop.name)
    end
  end
end
