require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @shop = FactoryBot.build(:shop)
  end

  describe '店の新規登録' do
    context '新規登録がうまくいくとき' do
      it '各項目が存在すれば登録できる' do
        expect(@shop).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @shop.name = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('店名を入力してください')
      end

      it 'prefecture_idが空だと登録できない' do
        @shop.prefecture_id = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('店舗の都道府県を選択してください')
      end

      it 'locationが空だと登録できない' do
        @shop.location = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('住所を入力してください')
      end

      it 'phone_numberが空だと登録できない' do
        @shop.phone_number = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('電話番号を入力してください')
      end

      it 'phone_numberが半角数字とハイフン以外だと登録できない' do
        @shop.phone_number = 'abcde'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'opening_timeが空だと登録できない' do
        @shop.opening_time = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('開店時間が不正です')
      end

      it 'closing_timeが空だと登録できない' do
        @shop.closing_time = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('閉店時間が不正です')
      end

      it 'parking_idが空だと登録できない' do
        @shop.parking_id = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('駐車場の有無を選択してください')
      end

      it 'credit_card_idが空だと登録できない' do
        @shop.credit_card_id = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('クレジットカードの利用を選択してください')
      end

      it 'electronic_money_idが空だと登録できない' do
        @shop.electronic_money_id = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('電子マネーの利用を選択してください')
      end
    end
  end
end
