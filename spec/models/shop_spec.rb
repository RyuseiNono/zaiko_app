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

      it 'locationが空だと登録できない' do
        @shop.location = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include('所在地を入力してください')
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
    end
  end
end
