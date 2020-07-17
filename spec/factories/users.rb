FactoryBot.define do
  factory :user do
    nickname              {"testman"}
    email                 {"kkk@gmail.com"}
    encrypted_password    {"00000000"}
    family_name           {"太郎"}
    first_name            {"山田"}
    family_name_kana      {"タロウ"}
    first_name_kana       {"ヤマダ"}
    postal_code           {"1234567"}
    prefecture            {"福岡県"}
    city                  {"福岡市中央区白金"}
    address               {"1-1-1"}
    building_name         {"コーポ102号室"}
    phone_number          {"08012341234"}
  end
end