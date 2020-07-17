require 'rails_helper'
describe User do

  it "nicknameがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, nickname: "")).to_not be_valid 
  end 

  it "emailがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid
  end

  it "passwordがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, encrypted_password: "")).to_not be_valid
  end

  it "passwordが7文字未満であれば登録できないこと" do
    expect(FactoryBot.build(:user, encrypted_password: "123456")).to_not be_valid
  end

  it "family_nameがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, family_name: "")).to_not be_valid
  end

  it "first_nameがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, first_name: "")).to_not be_valid
  end

  it "family_name_kanaがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, family_name_kana: "")).to_not be_valid
  end

  it "first_name_kanaがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, first_name_kana: "")).to_not be_valid
  end

  it "family_name_kanaが全角カタカナでない場合は登録できないこと" do
    expect(FactoryBot.build(:user, family_name_kana: "カナ")).to_not be_valid
  end

  it "first_name_kanaが全角カタカナでない場合は登録できないこと" do
    expect(FactoryBot.build(:user, first_name_kana: "カナ")).to_not be_valid
  end
  
  it "postal_codeがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, postal_code: "")).to_not be_valid
  end

  it "postal_codeが7桁未満の場合は登録できないこと" do
    expect(FactoryBot.build(:user, postal_code: "123456")).to_not be_valid
  end

  it "postal_codeが8桁以上の場合は登録できないこと" do
    expect(FactoryBot.build(:user, postal_code: "12345678")).to_not be_valid
  end

  it "postal_codeが半角数字でない場合は登録できないこと" do
    expect(FactoryBot.build(:user, postal_code: "１２３４５６７")).to_not be_valid
  end

  it "prefectureがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, prefecture: "")).to_not be_valid
  end

  it "cityがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, city: "")).to_not be_valid
  end

  it "addressがない場合は登録できないこと" do
    expect(FactoryBot.build(:user, address: "")).to_not be_valid
  end

end

