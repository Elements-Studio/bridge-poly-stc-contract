//# init -n test --public-keys Bridge=0x8085e172ecf785692da465ba3339da46c4b43640c3f92a45db803690cc3c4a36

//# faucet --addr Bridge --amount 10000000000

//# faucet --addr alice --amount 10000000000000000

//# faucet --addr bob --amount 10000000000000000

//# publish
module Bridge::CrossChainType {
    struct TokenA has copy, drop, store {}

    struct TokenB has copy, drop, store {}

    struct TokenC has copy, drop, store {}

    struct Starcoin has key, store {}

    struct Ethereum has key, store {}

    struct Bitcoin has key, store {}
}


//# run --signers Bridge
script {
    use Bridge::SafeMath;
    use Bridge::zion_cross_chain_manager;
    use Bridge::zion_lock_proxy;

    use StarcoinFramework::STC::STC;
    use StarcoinFramework::Signer;
    use StarcoinFramework::Token;

    fun test_genesis_initialize(signer: signer) {
        // header data from https://explorer.aptoslabs.com/txn/437065198/payload
        let raw_header = x"f9027fa02262877ad489b76e36b61c6bd3b81d17e2683b5264e0699973319c7a014842a2a01dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d4934794ad3bf5ed640cc72f37bd21d64a65c3c756e9c88ca00e17651f3d7ca06bbe00d14e68294146fcf42f426c82e318559857747696c0fda08247a985c2ed4d521bba502abfc50cd9700b646ef1eea58eceeb7821f8d5f69ea0d4e4d938901e00ea4da08917593dba522a19b68413162444389bb35251dd96e3b9010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018311f1c08411e1a30083029bf88463fbf10bb8830000000000000000000000000000000000000000000000000000000000000000f8618311f1c08311fd78f85494258af48e28e4a6846e931ddff8e1cdf8579821e5946a708455c8777630aac9d1e7702d13f7a865b27c948c09d936a1b408d6e0afaa537ba4e06c4504a0ae94ad3bf5ed640cc72f37bd21d64a65c3c756e9c88c80c080a063746963616c2062797a616e74696e65206661756c7420746f6c6572616e6365880000000000000000";
        zion_cross_chain_manager::init(&signer, raw_header, 318);

        let license = zion_cross_chain_manager::issueLicense(&signer, Signer::address_of(&signer), b"zion_lock_proxy");
        zion_lock_proxy::init(&signer);
        zion_lock_proxy::initTreasury<STC>(&signer);
        zion_lock_proxy::receiveLicense(license);

        // Bind STC
        zion_lock_proxy::bindProxy(&signer, 318, x"e52552637c5897a2d499fbf08216f73e");
        zion_lock_proxy::bindAsset<STC>(&signer, 318, b"0x1::STC::STC", SafeMath::log10(Token::scaling_factor<STC>()));
    }
}
// check: EXECUTED

//# run --signers alice
script {
    use Bridge::zion_lock_proxy;
    use StarcoinFramework::STC::STC;
    use StarcoinFramework::Account;
    use StarcoinFramework::Token;
    use StarcoinFramework::BCS;

    fun alice_lock_stc(sender: signer) {
        let to_chain_id = 318;
        let amount = 100 * Token::scaling_factor<STC>();
        let stc = Account::withdraw<STC>(&sender, amount);
        let dst_addr = BCS::to_bytes<address>(&@Bridge);
        zion_lock_proxy::lock<STC>(&sender, stc, to_chain_id, &dst_addr);
        assert!(zion_lock_proxy::getBalance<STC>() == amount, 10001);
    }
}
// check: EXECUTED

//# run --signers Bridge
script {
    use Bridge::zion_cross_chain_utils;
    use StarcoinFramework::Vector;
    use StarcoinFramework::Debug;

    fun raw_header_check(_sender: signer) {
        // Raw header from https://explorer.aptoslabs.com/txn/436952160/payload, next from the data using in `init` function
        let raw_header = x"f9027fa0c0af2ea5073b2109398dc8edd0ab1fad3ea599614efb98a0473075402d50fa00a01dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d4934794ad3bf5ed640cc72f37bd21d64a65c3c756e9c88ca080e68c19a1e96b4166c5c683189721a4be3939a76e08dbe60d1bbbcf5bd54ce6a0073efd48255496c73a9e4f5825f3d48c61c72a2c2a85acfed3fe601a6f76663fa0d4e4d938901e00ea4da08917593dba522a19b68413162444389bb35251dd96e3b9010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018311e6088411e1a30083029bf88463fbcde3b8830000000000000000000000000000000000000000000000000000000000000000f8618311e6088311f1c0f85494258af48e28e4a6846e931ddff8e1cdf8579821e5946a708455c8777630aac9d1e7702d13f7a865b27c948c09d936a1b408d6e0afaa537ba4e06c4504a0ae94ad3bf5ed640cc72f37bd21d64a65c3c756e9c88c80c080a063746963616c2062797a616e74696e65206661756c7420746f6c6572616e6365880000000000000000";
        let (epoch_end_height, new_validators) = zion_cross_chain_utils::decode_extra(&raw_header);
        Debug::print(&epoch_end_height);
        Debug::print(&new_validators);
        assert!(epoch_end_height > 0, 10010);
        assert!(Vector::length<vector<u8>>(&new_validators) > 0, 10011);
    }
}
// check: EXECUTED

//# run --signers Bridge
script {
    use Bridge::zion_cross_chain_manager;

    fun test_relayer_change_epoch(sender: signer) {
        // Raw header from https://explorer.aptoslabs.com/txn/436952160/payload, next from the data using in `init` function
        let raw_header = x"f9027fa0c0af2ea5073b2109398dc8edd0ab1fad3ea599614efb98a0473075402d50fa00a01dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d4934794ad3bf5ed640cc72f37bd21d64a65c3c756e9c88ca080e68c19a1e96b4166c5c683189721a4be3939a76e08dbe60d1bbbcf5bd54ce6a0073efd48255496c73a9e4f5825f3d48c61c72a2c2a85acfed3fe601a6f76663fa0d4e4d938901e00ea4da08917593dba522a19b68413162444389bb35251dd96e3b9010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018311e6088411e1a30083029bf88463fbcde3b8830000000000000000000000000000000000000000000000000000000000000000f8618311e6088311f1c0f85494258af48e28e4a6846e931ddff8e1cdf8579821e5946a708455c8777630aac9d1e7702d13f7a865b27c948c09d936a1b408d6e0afaa537ba4e06c4504a0ae94ad3bf5ed640cc72f37bd21d64a65c3c756e9c88c80c080a063746963616c2062797a616e74696e65206661756c7420746f6c6572616e6365880000000000000000";
        let raw_seals = x"f8c9b8415d25df113e583c8c03243e475abc43c61a4de048ad06204f6ad2f5a2f66a2e451af969c6793fc4f59ce51fcba1c65df8ae54ee04c566f94c4c7361ecbd39ed4b01b841261ad1586ee53804f515fa79364c3d58d7c91b2341b183d0bda45d95625295ea3cffc4dc6a552f78688913783aa25a865e5c8e22830f9b300d691583a254b08401b84158b827e764f6f24900a7016bff84ede88d51d45ac963e1dc32b40581dac223a16d06a67a84c45c69c627bbf4c54c8f6968dc298b13fee46572d9aae9a99a460100";
        zion_cross_chain_manager::change_epoch(&sender, raw_header, raw_seals);
    }
}
// check: EXECUTED
//
// //# run --signers Bridge
// script {
//     use Bridge::zion_lock_proxy;
//     use StarcoinFramework::STC::STC;
//
//     fun bridge_unlock_to_bob(sender: signer) {
//         let raw_header = x"f90228a0e789de6eea865ba1473e24ee762db4c28db2b23c12e4210c310fddbf510b7b22a01dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347948c09d936a1b408d6e0afaa537ba4e06c4504a0aea0260bc6665a43b480adc67973665e10b0a9e281a15b2529dc544f40ac3e96e7a8a0e28bad27e644256722f437ea9e61f20203779381fd20bc30f54e68a4dcdb0f93a0d4e4d938901e00ea4da08917593dba522a19b68413162444389bb35251dd96e3b901000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001830a89068411e1a30083029bf88463e5b665ad0000000000000000000000000000000000000000000000000000000000000000cc830a8750830a9308c080c080a063746963616c2062797a616e74696e65206661756c7420746f6c6572616e6365880000000000000000";
//         let raw_seals = x"f8c9b841d91c0fe91339699ab29269c9de163a1235a9e757b113462287ea45061cf6c3c30205f11d19851d2abc53063a5d04d0c5a61e0ba7ada9687f1578362000b59e1601b841217bc8ffc37fcc8da39d7e6480c66c44ca555a6e9c82e16cbcc2bedfbafac6c83e7bd2504e4d8e9d9968f70c1f8516b9dc3167e9fc7964853f0667bd803eeb6b00b8418b4988c3b767141108e50fbeec15ee3cc61378054ac54687f04cbe826b078e8d522b53515e53f3c20c014f533e954bcacb50d292e08b1282158232513ba5fd0700";
//         let account_proof = x"b90312f90211a05c398cb1eda7694292299ed650b54e8533afd3ec67d987d74256042cc0afaa89a0bfcbc67181cbc6da16c5ca7721f67c07144deb406d487dc4c7ca960e1f73699aa0151c8b86e61b44a08550eaf2d1d9de50ba11ceb46110ddb430927d3ac1aa6982a03320618fc57b3480351aacdf5e1b839c3fa94255e19526aceff3e51236f05d8ba0f7b63015a5d5c255af1ef84a0c7f2f968ae6510aa900dd0e599711cfb6aef726a04ae29f1939f47908e11cf0b17a9c98b57ac3f1546305803927c261f1eba93f28a0d3834ea268371096326a82cd44b05456711ece957315da1c8aebf3ce42700313a0c9965d4d47ae31b4496ca1049805e0dd80dbffaf2ab3810a680d2a52277e53f5a05fa6237ee655c91d90abb91e57a219016d6cee7173d6731eca0a51981be4de78a00e3e09faa71087a7c857a545e6302b2a43373d63a32581204e39524a872909a4a0c8e1303c77011c6b4482e0cf7371d1f26c42a1e185cca416845dc59f7dcf64e1a0935d17f9d7aea1cae0d64371e65fccd9ada73e66701e0c9961d59af5410157e0a07a679adab9f6a719934731a738de3dd4966db4dcc3f4b9ea392a2656a1afef52a02340cca7e5ae9ceb2a5153eea30d518822645eb13a6a6c0718cb558e65521b95a09bb0df52d18cb4f016f9c9aee8eb63660a20263e066dfaab80acfeb6472d90dda00834018ad1bc9f657169082811648dae209be8e6e3726934cae04a4c79c996c280f8918080a0c34c47096aaaafa401dd3aa184c24f1de0fdaaabf43603b73d4f9a0e188483b2808080a0fc474ccabb154b901ee066afd59f8e96bb80c75f7130c3ae56f01d012b6e2e7380a09ae5aa0eb9c85b4aac877dc3f0f3f8453277f4fb3c8c1a2f032e950c109cc225808080808080a0ef35d90458d529d915a0ddff88d0764027cac542530bfac86eb00c3cb333e24180f869a02074e65ccffb133d9db4ff637e62532ef6ecef3223845d02f522c55786782911b846f8440180a079e56c54a0ee0417e19c61f78cd3f51b93775ed7985d12a15468752bad8af0f7a0c874e65ccffb133d9db4ff637e62532ef6ecef3223845d02f522c55786782911";
//         let storage_proof = x"b904fff90211a06a63545609aaac32b7be25ce25c85871c08804684179e8cefd3cda6743f14d41a0d3571b75f95e0585e4f282ffef2a25545cc477f3b1d2e99ea2d08ded517fca4ca0f347b96506b1d4958f0c2f9cbffcf12779b4d1dfddcaadb5c1ec3777285cdc32a03971ff556f22b46a85831eae6c51a14088f65dd780877bb2f53ae70a33514609a0cbc27dbc447bf1ca34ef7b07d1af2d28a64b1bfcb8689c5b5ca2fd0c7619aebca0e12f140b3d2b7e4faa3b0a361d4f79b208ef0134504f01ffa3b28b9ff7d38b46a0f6a8554d58f985f822a292e13558791a77667061519b8a5aeed08807bf61ddcfa088eee45b7c351ba6ee3d7315dd04b6285a2939f5843b4dd55cc35151115a9b61a0105ceccd10e7df96fb9f6288c0790455af4606951db378d8d6f752287888b761a07ef99d77cc84a201e8ff8ea19b057432f2561db1d493dddfe1168a17fac23560a01cbfc44e5a40ce13b936d6df61cd1d1745e1da14d70cc980db14b9d45ea4fdeea0f8300b7d4b1c181901ba955213d6c19eb14ce5f7a86658d09b4cc77588271326a0e66f770783817d24c34e3822d46f217829a28921b030d18f3770e9fa171596d6a0a70c83b847dfc1d596ddc1acfe30d1dfd3d6cc77f80c2c1d6ef3863edd7498a6a06f3b8e94f211ace8bc1ff645e6b01de09a78e6f4bb751d3f491f81602be4e9c4a01095608d9b1a3323dfc6dd4a7ab5131b8c9d2508f81f19a3492cbc73efa2be8f80f90211a00b088761926bdacb35aeb56214cdb86b15629a630aaa46689ca1c28b2c5f23caa0eaff97a6a5950afaec08dad96d83d80888935293d9bce3b68c867fc471554099a09b86e8f8d8ac35d8a359aa189ab305d0756c790fe00b78166c3ff0531643f0dea05138d606f0049a322d092d1b6e9fd4e5081b5cc1163fd349398c284af1bebb46a0cff50b6757be611eae23ec00f0e177267e1d96fca91ddcf368df832293a333cca0641d526b260d72ee1ee1f0e04a0eb8afe0d68cb1701f1d54d21d6c5ca5b7c76ea02c2ba26b07310fe73029e6a10efcfe8cd8e3f8b611b64819c21a7e8f4f14496ca0a9877dba01d5edc6abf4250b7dd0a124d1c7004007fcf851ab57cab7d5a75733a0a076672b702d3cf0a471657bd286f88e536d2fc1559d485d47cb315abaab9924a0bdd71c5cb557f3f110c44bf89966ce50925434b48b36035052dea2acfcd530d3a0686e00ca1c2f9c16ebff92fe5764649f1357e6f98b3d4f167e9529965a26110ba0652c996489b57d9f414d46f3f74bfba38cd03571286cd7395ff70f11eab0e59ca03b17c2494d894e7e8b8702ddb736ff49cf9908aea2943a63174eea50f744ae10a052bc8d48b8785424fa19980eb8f0e00b3e77aa55d59408024b9605e10480487aa044d534fe3cca01e985fc18aed49ece36aa15b4b73aa1f0127bb8a4a07ca20b7aa01889ffb1e44537d9ba7a97f274d7bcddf1828a818910216b899b8fd336e1718a80f8918080808080808080a0b27769fd49be392cf63de2549a8b6d018dc540da6ccf8d07dd1ba5a909be275da05e61c298afa5308630ca1189e8fd6597600aa9b25ec344cf469258f995cd7f00a02361ef9a49109c1de419f8dad21d565ce511e8d5a6ad183a111920fb05bef00c80808080a098af313b15cd56dc55f98bbad5256462afc3199c83658f6309f8cfdf2d6b302c80f8429f35b5a5d11230e726459f0201c38e4b163bacf9dfb51b50aa1d5f223e98601aa1a0ffa7b02d61f5f6bd280415da199f1c23cdb2705344d080de9c256e491640649c";
//         let raw_cross_tx = x"f901eba08de1a28eba3c77247fa0cb00bcd6ade60a4d4e369104764b008ff31f4deaeee04ff901c6a00000000000000000000000000000000000000000000000000000000000000018a0159292e8e815946fb4b718d4fd31251fd5113cbee1217d20f929e6683d74815094787f2d5725b944e0a6dcac3b5ed2d1af39ee8c978203e6b8c00000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000203032aaa1aa47784587842b1b44d7f8837edaa712782ae8d892e8ca04e4043e0d000000000000000000000000000000000000000000000000000000000000000a6c6f636b5f70726f78790000000000000000000000000000000000000000000086756e6c6f636bb8a15f3078313a3a636f696e3a3a436f696e3c3078663132613466663637333739376432303330376630383131303331383663366137323561366338363039613535316264633133656533303836326632636531353a3a6e623a3a4e42436f696e3e2049bf121f491c627e20947d0537e6631850a643e36590b3ddac864be228d26b7b0100000000000000000000000000000000000000000000000000000000000000";
//         zion_lock_proxy::relay_unlock_tx<STC>(
//             &sender,
//             raw_header,
//             raw_seals,
//             account_proof,
//             storage_proof,
//             raw_cross_tx
//         );
//     }
// }
// // check: EXECUTED