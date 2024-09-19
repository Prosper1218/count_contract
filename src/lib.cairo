#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increase_count(ref self: TContractState);
    fn decrease_count(ref self: TContractState);
    fn current_count(self: @TContractState) -> u128;
}

#[starknet::contract]
pub mod CounterContract {
    #[storage]
    struct Storage {
        count: u128
    }
    //  our constructor to save state
    #[constructor]
    fn constructor(ref self: ContractState, initial_val: u128) {
        self.count.write(initial_val)
    }


    #[abi(embed_v0)]
    impl CounterContract of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState) {
            let C_ount = self.count.read();
            self.count.write(C_ount + 1)
        }
        fn decrease_count(ref self: ContractState) {
            let C_ount = self.count.read();
            self.count.write(C_ount - 1)
        }
        fn current_count(self: @ContractState) -> u128 {
            self.count.read()
        }
    }
}
