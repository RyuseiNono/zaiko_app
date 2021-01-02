require 'rails_helper'
describe Admin do
  before do
    @admin = FactoryBot.build(:admin)
  end

  describe '店舗アカウント新規登録' do
    context '新規登録がうまくいくとき' do
      it '各項目が存在すれば登録できる' do
        expect(@admin).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @admin.name = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include('店名を入力してください')
      end

      it 'emailが空では登録できない' do
        @admin.email = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it 'emailには@がないと登録できない' do
        @admin.email = 'aaaaa'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it '重複したemailが存在する場合登録できない' do
        @admin.save
        another_admin = FactoryBot.build(:admin)
        another_admin.email = @admin.email
        another_admin.valid?
        expect(another_admin.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'passwordが空では登録できない' do
        @admin.password = ''
        @admin.password_confirmation = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5文字以下であれば登録できない' do
        @admin.password = '12345'
        @admin.password_confirmation = '12345'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @admin.password_confirmation = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワード(確認)とパスワードの入力が一致しません')
      end

      it 'passwordが全角では登録できない' do
        @admin.password = 'あいうえおか'
        @admin.password_confirmation = 'あいうえおか'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは不正な値です')
      end
    end
  end
end
