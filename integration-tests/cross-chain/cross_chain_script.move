//# init -n test --public-keys Bridge=0x8085e172ecf785692da465ba3339da46c4b43640c3f92a45db803690cc3c4a36

//# faucet --addr Bridge --amount 10000000000

//# faucet --addr bob --amount 10000000000000000

//# run --signers Bridge
script {
    use Bridge::CrossChainScript;

    fun test_genesis_init(signer: signer) {
        let raw_header = x"000000009b9156170000000000000000000000000000000000000000000000000000000000000000000000006de0a8f7ee3fb67d8e04ac9547f3615e59adc6e0a2309c90080a272dc1fa1fd90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8365b000000001dac2b7c00000000fd1a057b226c6561646572223a343239343936373239352c227672665f76616c7565223a22484a675171706769355248566745716354626e6443456c384d516837446172364e4e646f6f79553051666f67555634764d50675851524171384d6f38373853426a2b38577262676c2b36714d7258686b667a72375751343d222c227672665f70726f6f66223a22785864422b5451454c4c6a59734965305378596474572f442f39542f746e5854624e436667354e62364650596370382f55706a524c572f536a5558643552576b75646632646f4c5267727052474b76305566385a69413d3d222c226c6173745f636f6e6669675f626c6f636b5f6e756d223a343239343936373239352c226e65775f636861696e5f636f6e666967223a7b2276657273696f6e223a312c2276696577223a312c226e223a372c2263223a322c22626c6f636b5f6d73675f64656c6179223a31303030303030303030302c22686173685f6d73675f64656c6179223a31303030303030303030302c22706565725f68616e647368616b655f74696d656f7574223a31303030303030303030302c227065657273223a5b7b22696e646578223a312c226964223a2231323035303238313732393138353430623262353132656165313837326132613265336132386439383963363064393564616238383239616461376437646437303664363538227d2c7b22696e646578223a322c226964223a2231323035303338623861663632313065636664636263616232323535326566386438636634316336663836663963663961623533643836353734316366646238333366303662227d2c7b22696e646578223a332c226964223a2231323035303234383261636236353634623139623930363533663665396338303632393265386161383366373865376139333832613234613665666534316330633036663339227d2c7b22696e646578223a342c226964223a2231323035303236373939333061343261616633633639373938636138613366313265313334633031393430353831386437383364313137343865303339646538353135393838227d2c7b22696e646578223a352c226964223a2231323035303234363864643138393965643264316363326238323938383261313635613065636236613734356166306337326562323938326436366234333131623465663733227d2c7b22696e646578223a362c226964223a2231323035303265623162616162363032633538393932383235363163646161613761616262636464306363666362633365373937393361633234616366393037373866333561227d2c7b22696e646578223a372c226964223a2231323035303331653037373966356335636362323631323335326665346132303066393964336537373538653730626135336636303763353966663232613330663637386666227d5d2c22706f735f7461626c65223a5b362c342c332c352c362c312c322c352c342c372c342c322c332c332c372c362c352c342c362c352c312c342c332c312c322c352c322c322c362c312c342c352c342c372c322c332c342c312c352c372c342c312c322c322c352c362c342c342c322c372c332c362c362c352c312c372c332c312c362c312c332c332c322c342c342c312c352c362c352c312c322c362c372c352c362c332c342c372c372c332c322c372c312c352c362c352c322c332c362c322c362c312c372c372c372c312c372c342c332c332c332c322c312c372c355d2c226d61785f626c6f636b5f6368616e67655f76696577223a36303030307d7d9fe171f3fe643eb1c188400b828ba184816fc9ac0000";
        let pub_key_list = x"1205041e0779f5c5ccb2612352fe4a200f99d3e7758e70ba53f607c59ff22a30f678ff757519efff911efc7ed326890a2752b9456cc0054f9b63215f1d616e574d6197120504468dd1899ed2d1cc2b829882a165a0ecb6a745af0c72eb2982d66b4311b4ef73cff28a6492b076445337d8037c6c7be4d3ec9c4dbe8d7dc65d458181de7b5250120504482acb6564b19b90653f6e9c806292e8aa83f78e7a9382a24a6efe41c0c06f39ef0a95ee60ad9213eb0be343b703dd32b12db32f098350cf3f4fc3bad6db23ce120504679930a42aaf3c69798ca8a3f12e134c019405818d783d11748e039de8515988754f348293c65055f0f1a9a5e895e4e7269739e243a661fff801941352c387121205048172918540b2b512eae1872a2a2e3a28d989c60d95dab8829ada7d7dd706d658df044eb93bbe698eff62156fc14d6d07b7aebfbc1a98ec4180b4346e67cc3fb01205048b8af6210ecfdcbcab22552ef8d8cf41c6f86f9cf9ab53d865741cfdb833f06b72fcc7e7d8b9e738b565edf42d8769fd161178432eadb2e446dd0a8785ba088f120504eb1baab602c5899282561cdaaa7aabbcdd0ccfcbc3e79793ac24acf90778f35a059fca7f73aeb60666178db8f704b58452b7a0b86219402c0770fcb52ac9828c";

        CrossChainScript::init_genesis(
            signer,
            raw_header,
            pub_key_list);
    }
}
// check: EXECUTED

//# run --signers Bridge
script {
    use Bridge::CrossChainConfig;

    fun test_cross_chain_config_freeze(signer: signer) {
        CrossChainConfig::set_freeze(&signer, true);
    }
}
// check: EXECUTED

//# run --signers Bridge
script {
    use StarcoinFramework::STC;
    use StarcoinFramework::BCS;
    use Bridge::LockProxy;
    use Bridge::CrossChainGlobal;
    use Bridge::CrossChainManager;

    fun cant_do_lock(signer: signer) {
        let to_chain_id = 31;
        let ( parameters, _,) = LockProxy::lock_with_param_pack<STC::STC, CrossChainGlobal::STARCOIN_CHAIN>(
            &signer, to_chain_id, &BCS::to_bytes(&@bob), 10000000);

        // Do crosschain option from cross chain manager
        CrossChainManager::cross_chain_with_param_pack(&signer, parameters);
    }
}
// check: "Keep(ABORTED { code: 26369"

