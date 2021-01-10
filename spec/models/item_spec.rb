require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の新規登録' do
    context '新規登録がうまくいくとき' do
      it '各項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end

      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('値段を入力してください')
      end

      it 'priceが8桁以上だと登録できない' do
        @item.price = 123456789
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は8文字以内で入力してください')
      end

      it 'priceが文字だと登録できない' do
        @item.price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は数値で入力してください')
      end

      it 'priceが整数でないと登録できない' do
        @item.price = 100.5
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は整数で入力してください')
      end

      it 'countが空だと登録できない' do
        @item.count = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('在庫数を入力してください')
      end

      it 'countが3桁以上だと登録できない' do
        @item.count = 123
        @item.valid?
        expect(@item.errors.full_messages).to include('在庫数は2文字以内で入力してください')
      end

      it 'countが整数でないと登録できない' do
        @item.count = 10.5
        @item.valid?
        expect(@item.errors.full_messages).to include('在庫数は整数で入力してください')
      end

      it 'shopが紐付いていないと登録できない' do
        @item.shop = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('店舗を入力してください')
      end

    end
  end
end
