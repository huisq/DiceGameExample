
use snforge_std::{ declare, ContractClassTrait, start_cheat_caller_address };
use starknet::{ ContractAddress, contract_address_const};

use dice_random_demo::IDiceGameDispatcher;
use dice_random_demo::IDiceGameDispatcherTrait;
use openzeppelin_testing::{declare_and_deploy};


// pub fn OWNER() -> ContractAddress {
//     contract_address_const::<'OWNER'>()
// }


fn setup_dispatcher() -> IDiceGameDispatcher {
    let mut calldata = ArrayTrait::new();
    let vrf: ContractAddress = 0x60c69136b39319547a4df303b6b3a26fab8b2d78de90b6bd215ce82e9cb515c.try_into().unwrap();
    calldata.append(vrf.into());
    calldata.append(contract_address_const::<'OWNER'>().into()); //owner in constructer 
    
    let address = declare_and_deploy("DiceGame", calldata); //mod name

    start_cheat_caller_address(address, contract_address_const::<'OWNER'>());
    IDiceGameDispatcher { contract_address: address}
}


#[test]
fn test_dispatch() {
    let dispatcher = setup_dispatcher();
    let game = dispatcher.get_game_window();
    println!("game_window: {game}");
}