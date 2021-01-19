require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージの新規登録' do
    context '新規登録がうまくいくとき' do
      it 'textとshopとuserが存在すれば登録できる' do
        @message.admin = nil
        expect(@message).to be_valid
      end

      it 'textとshopとadminが存在すれば登録できる' do
        @message.user = nil
        expect(@message).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'textが空だと登録できない' do
        @message.text = ''
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージを入力してください')
      end

      it 'shopが空だと登録できない' do
        @message.shop = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('店舗を入力してください')
      end
    end
  end
end
