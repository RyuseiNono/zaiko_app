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

      it 'countが空だと登録できない' do
        @item.count = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('在庫数を入力してください')
      end
    end
  end
end
