//# init -n test --public-keys Bridge=0x57e74d84273e190d80e736c0fd82e0f6a00fb3f93ff2a8a95d1f3ad480da36ce

//# faucet --addr bob --amount 10000000000000000

//# faucet --addr Bridge --amount 10000000000000000

//# run --signers Bridge
script {
    use Bridge::CrossChainLibrary;
    use StarcoinFramework::Vector;
    use StarcoinFramework::Debug;

    fun test_verify_sig(_: signer) {
        let _raw_header = x"000000009b91561700000000f48a4057bef268cc3fdb034e69dc2e942907e08ac4a420d1b196b8c28ebf5bf2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a8be0a1605a63a31704aec4eb4f1023f1ecc2934bd86f119ab77526f9477af9a57e1a5f508e0000410782720ab189fffd84057b226c6561646572223a332c227672665f76616c7565223a22424f4f336f58796b32524970655651593338547133714a423832737a4a68366e4f6f724a55702f4a4d582b474c707a347a497347394c4a6c34784a6f34657448674f56357169364d484b6674714f69724f755a495a69593d222c227672665f70726f6f66223a22635953525746506f69394748414247526255646836612b35506f4f317776354a557a53417457786845637071757430536a595873344c7453353574534a74334174493059616d4c67524a797a524f68564756626d34673d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a33363433322c226e65775f636861696e5f636f6e666967223a7b2276657273696f6e223a312c2276696577223a342c226e223a382c2263223a322c22626c6f636b5f6d73675f64656c6179223a31303030303030303030302c22686173685f6d73675f64656c6179223a31303030303030303030302c22706565725f68616e647368616b655f74696d656f7574223a31303030303030303030302c227065657273223a5b7b22696e646578223a312c226964223a2231323035303238313732393138353430623262353132656165313837326132613265336132386439383963363064393564616238383239616461376437646437303664363538227d2c7b22696e646578223a342c226964223a2231323035303236373939333061343261616633633639373938636138613366313265313334633031393430353831386437383364313137343865303339646538353135393838227d2c7b22696e646578223a332c226964223a2231323035303234383261636236353634623139623930363533663665396338303632393265386161383366373865376139333832613234613665666534316330633036663339227d2c7b22696e646578223a352c226964223a2231323035303234363864643138393965643264316363326238323938383261313635613065636236613734356166306337326562323938326436366234333131623465663733227d2c7b22696e646578223a382c226964223a2231323035303339333432313434356239343231626434636339306437626338386339333031353538303437613736623230633539653763353131656537643232393938326231227d2c7b22696e646578223a322c226964223a2231323035303338623861663632313065636664636263616232323535326566386438636634316336663836663963663961623533643836353734316366646238333366303662227d2c7b22696e646578223a372c226964223a2231323035303331653037373966356335636362323631323335326665346132303066393964336537373538653730626135336636303763353966663232613330663637386666227d2c7b22696e646578223a362c226964223a2231323035303265623162616162363032633538393932383235363163646161613761616262636464306363666362633365373937393361633234616366393037373866333561227d5d2c22706f735f7461626c65223a5b322c382c352c352c382c372c312c342c352c362c352c342c372c372c332c332c342c362c312c322c342c382c352c342c372c342c362c362c322c322c312c312c382c382c362c362c362c372c382c372c342c382c352c312c332c332c382c352c332c362c332c362c372c352c362c322c332c312c322c362c352c322c312c342c322c312c382c342c382c332c382c372c372c352c312c372c342c342c312c352c322c352c362c312c322c382c332c332c312c332c312c342c312c372c382c362c382c322c352c312c342c352c332c322c322c322c382c332c332c332c362c372c342c372c342c322c372c352c362c375d2c226d61785f626c6f636b5f6368616e67655f76696577223a36303030307d7df8fc7a1f6a856313c591a3a747f4eca7218a820b";
        let _sig_list = x"7d588d79ac9f0931c69150de6bfe5289f0147893781bffbcc32b5e07bd687d1048dda039ffc1e87de2e98610dc876e97411d604948473904b12b64bed8880bcc00ea8be33bb197c82690987e22e970221de11dfa019f470d784ef211edb6c9a3fd75bf74904adea08ed37a635c4dc58ccc21369afc1abcab4696a42be1097468a400289be668444122fd1d48c62781ded43e6fbda9bdd587dc7ee1bd326390d70e3f0e174fbd4854ed96c697dcee93feabbf7cdf290ebee93d4f5156d75d62b80ba301e79df9e679af49c403bbf05a24af2307adc96b641f4501fdb96e6704d27b2a87278e15bfee5909d4fa62dd45907cba23f833b3e96378d140d56722d1f59821e4006d8349493021e2cd6af96524357867b6be9d24ef33aaf66c430d5f91c33253304380ee17c6839fed964e7ba4910dd26533125b548cff6450140b10caec1b08fe01";

        let _keeper_slice_0:vector<u8> = x"09732fac787afb2c5d3abb45f3927da18504f10f";
        let _keeper_slice_1:vector<u8> = x"7fbfc361a31bdbc57ccc7917fe5dbdbba744e3a8";
        let _keeper_slice_2:vector<u8> = x"a42a4e85034d5bebc225743da400cc4c0e43727a";
        let _keeper_slice_3:vector<u8> = x"5d60f39ab5bec41fa712562a5c098d8a128cd406";
        let _keeper_slice_4:vector<u8> = x"da9cdffbfccab4181efc77831dc8ce7c442a7c7f";
        let _keeper_slice_5:vector<u8> = x"b98d72dc7743ede561f225e1bf258f49aea8f786";
        let _keeper_slice_6:vector<u8> = x"02cbc020209ef8835388882e2c4c4e6acef96f28";

        let _keepers = Vector::empty();
        Vector::push_back(&mut _keepers, _keeper_slice_0);
        Vector::push_back(&mut _keepers, _keeper_slice_1);
        Vector::push_back(&mut _keepers, _keeper_slice_2);
        Vector::push_back(&mut _keepers, _keeper_slice_3);
        Vector::push_back(&mut _keepers, _keeper_slice_4);
        Vector::push_back(&mut _keepers, _keeper_slice_5);
        Vector::push_back(&mut _keepers, _keeper_slice_6);

        let m = 5;

        let value = CrossChainLibrary::verify_sig(&_raw_header, &_sig_list, &_keepers, m);
        Debug::print(&value);
        assert!(value == true, 2011);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {
    use Bridge::CrossChainLibrary;
    use StarcoinFramework::Vector;
    use StarcoinFramework::Debug;

    fun test_get_book_keeper() {
        let _key_len = 8;
        let _m = 6;
        let _pub_key_list = x"1205041e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff757519efff911efc7ed326890a2752b9456cc0054f9b63215f1d616e574d6197120504468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef73cff28a6492b076445337d8037c6c7be4d3ec9c4dbe8d7dc65d458181de7b5250120504482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39ef0a95ee60ad9213eb0be343b703dd32b12db32f098350cf3f4fc3bad6db23ce120504679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988754f348293c65055f0f1a9a5e895e4e7269739e243a661fff801941352c387121205048172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658df044eb93bbe698eff62156fc14d6d07b7aebfbc1a98ec4180b4346e67cc3fb01205048b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b72fcc7e7d8b9e738b565edf42d8769fd161178432eadb2e446dd0a8785ba088f12050493421445b9421bd4cc90d7bc88c9301558047a76b20c59e7c511ee7d229982b142bbf593006e8099ad4a2e3a2a9067ce46b7d54bab4b8996e7abc3fcd8bf0a5f120504eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";
        let _next_book_keeper = x"f8fc7a1f6a856313c591a3a747f4eca7218a820b";

        let _keeper_slice_0: vector<u8> = x"09732fac787afb2c5d3abb45f3927da18504f10f";
        let _keeper_slice_1: vector<u8> = x"7fbfc361a31bdbc57ccc7917fe5dbdbba744e3a8";
        let _keeper_slice_2: vector<u8> = x"a42a4e85034d5bebc225743da400cc4c0e43727a";
        let _keeper_slice_3: vector<u8> = x"5d60f39ab5bec41fa712562a5c098d8a128cd406";
        let _keeper_slice_4: vector<u8> = x"da9cdffbfccab4181efc77831dc8ce7c442a7c7f";
        let _keeper_slice_5: vector<u8> = x"b98d72dc7743ede561f225e1bf258f49aea8f786";
        let _keeper_slice_6: vector<u8> = x"b27c53c3fac2d374d86187a51c5e4404fc51bc04";
        let _keeper_slice_7: vector<u8> = x"02cbc020209ef8835388882e2c4c4e6acef96f28";

        let _keepers = Vector::empty();
        Vector::push_back(&mut _keepers, _keeper_slice_0);
        Vector::push_back(&mut _keepers, _keeper_slice_1);
        Vector::push_back(&mut _keepers, _keeper_slice_2);
        Vector::push_back(&mut _keepers, _keeper_slice_3);
        Vector::push_back(&mut _keepers, _keeper_slice_4);
        Vector::push_back(&mut _keepers, _keeper_slice_5);
        Vector::push_back(&mut _keepers, _keeper_slice_6);
        Vector::push_back(&mut _keepers, _keeper_slice_7);

        let (next_book_keeper, keepers) = CrossChainLibrary::get_book_keeper(_key_len, _m, &_pub_key_list);

        Debug::print(&333666);
        let i = 0;
        while (i < Vector::length(&_keepers)) {
            Debug::print<vector<u8>>(Vector::borrow(&_keepers, i));
            i = i + 1;
        };

        assert!(_next_book_keeper == next_book_keeper, 2014);
        assert!(_keepers == keepers, 2015);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {
    use StarcoinFramework::Hash;

    fun test_keccak_256() {
        let _data = x"eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";
        let _hash = x"62bc278075b01f1f9882ca1d02cbc020209ef8835388882e2c4c4e6acef96f28";
        let hash = Hash::keccak_256(_data);
        assert!(_hash == hash, 2030);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {
    use StarcoinFramework::Hash;

    fun test_sha2_256() {
        let _data = x"0800231205031e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff23120502468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef7323120502482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f3923120502679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988231205028172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658231205038b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b2312050393421445b9421bd4cc90d7bc88c9301558047a76b20c59e7c511ee7d229982b123120502eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a0600";
        let _hash = x"6c041508df3a118feb6e59cea2fc23a2be8a04e911d13a30c94d66589f971bf2";
        let hash = Hash::sha2_256(_data);
        assert!(_hash == hash, 2031);
    }
}

// check: EXECUTED

//# run --signers Bridge
script {
    use StarcoinFramework::Hash;

    fun test_ripemd160() {
        let _data = x"6c041508df3a118feb6e59cea2fc23a2be8a04e911d13a30c94d66589f971bf2";
        let _hash = x"f8fc7a1f6a856313c591a3a747f4eca7218a820b";
        let hash = Hash::ripemd160(_data);
        assert!(_hash == hash, 2032);
    }
}

// check: EXECUTED



//# run --signers Bridge
script {
    use StarcoinFramework::Debug;
    use Bridge::Bytes;

    const POLYCHAIN_PUBKEY_LEN: u64 = 67;

    fun test_bytes_slice() {
        let _public_key_list = x"1205041e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff757519efff911efc7ed326890a2752b9456cc0054f9b63215f1d616e574d6197120504468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef73cff28a6492b076445337d8037c6c7be4d3ec9c4dbe8d7dc65d458181de7b5250120504482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39ef0a95ee60ad9213eb0be343b703dd32b12db32f098350cf3f4fc3bad6db23ce120504679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988754f348293c65055f0f1a9a5e895e4e7269739e243a661fff801941352c387121205048172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658df044eb93bbe698eff62156fc14d6d07b7aebfbc1a98ec4180b4346e67cc3fb01205048b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b72fcc7e7d8b9e738b565edf42d8769fd161178432eadb2e446dd0a8785ba088f12050493421445b9421bd4cc90d7bc88c9301558047a76b20c59e7c511ee7d229982b142bbf593006e8099ad4a2e3a2a9067ce46b7d54bab4b8996e7abc3fcd8bf0a5f120504eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";
        let public_key = Bytes::slice(&_public_key_list, 0*POLYCHAIN_PUBKEY_LEN, 0*POLYCHAIN_PUBKEY_LEN + POLYCHAIN_PUBKEY_LEN);
        Debug::print(&public_key);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {
    use StarcoinFramework::Debug;
    use Bridge::Bytes;

    fun test_bytes_concat() {
        let _data = x"6c041508df3a118feb6e59cea2fc23a2be8a04e911d13a30c94d66589f971bf2";
        let _hash = x"f8fc7a1f6a856313c591a3a747f4eca7218a820b";
        let buf = Bytes::concat(&_data, _hash);
        Debug::print(&buf);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {
    use StarcoinFramework::Debug;
    use Bridge::ZeroCopySink;

    fun test_write_var_bytes() {
        let _data = x"120502482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39";
        let buf = ZeroCopySink::write_var_bytes(&_data);
        Debug::print(&buf);
    }
}

// check: EXECUTED


//# run --signers Bridge
script {

    fun test_compare() {
        let _hash = x"62bc278075b01f1f9882ca1d02cbc020209ef8835388882e2c4c4e6acef96f28";
        let hash = x"62bc278075b01f1f9882ca1d02cbc020209ef8835388882e2c4c4e6acef96f28";
        assert!(_hash == hash, 2030);
    }
}

// check: EXECUTED

//# run --signers Bridge
script {
    use StarcoinFramework::Compare;

    const EQUAL: u8 = 0;
    const LESS_THAN: u8 = 1;
    const GREATER_THAN: u8 = 2;

    fun test_compare_cmp() {
        let _hash = x"62bc278075b01f1f9882ca1d02cbc020209ef8835388882e2c4c4e6acef96f28";
        let hash = x"62bc278075b01f1f9882ca1d02cbc020209ef8835388882e2c4c4e6acef96f28";
        let order = Compare::cmp_bytes(&_hash, &hash);
        assert!(EQUAL == order, 2031);
    }
}

// check: EXECUTED