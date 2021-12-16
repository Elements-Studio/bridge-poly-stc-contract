address 0x2d81a0427d64ff61b11ede9085efa5ad {

module MerkleProofStructuredHash {
    use 0x1::Hash;
    use 0x1::Vector;
    use 0x1::BCS;

    use 0x2d81a0427d64ff61b11ede9085efa5ad::MerkleProofElementBits;

    const STARCOIN_HASH_PREFIX: vector<u8> = b"STARCOIN::";

    const ERROR_INVALID_HASH_LENGTH : u64 = 101;

    public fun hash<MoveValue: store>(structure: vector<u8>, data: &MoveValue): vector<u8> {
        let prefix_hash = Hash::sha3_256(concat(&STARCOIN_HASH_PREFIX, structure));
        let bcs_bytes = BCS::to_bytes(data);
        Hash::sha3_256(concat(&prefix_hash, bcs_bytes))
    }

    public fun create_literal_hash(word: &vector<u8>) : vector<u8> {
        let word_length = Vector::length(word);
        assert(word_length <= MerkleProofElementBits::hash_length(), ERROR_INVALID_HASH_LENGTH);
        if (word_length < MerkleProofElementBits::hash_length()) {
            let result = Vector::empty();
            let idx = 0;
            while (idx < MerkleProofElementBits::hash_length()) {
                if (idx < word_length) {
                    Vector::push_back(&mut result, *Vector::borrow(word, idx));
                } else {
                    Vector::push_back(&mut result, 0);
                };
                idx = idx + 1;
            };
            result
        } else {
            *word
        }
    }

    fun concat(v1: &vector<u8>, v2: vector<u8>): vector<u8> {
        let data = *v1;
        Vector::append(&mut data, v2);
        data
    }
}
}