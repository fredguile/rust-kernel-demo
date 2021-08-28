#![no_std]
#![no_main]
#![feature(abi_x86_interrupt)]

mod interrupts;
mod vga_buffer;

use core::panic::PanicInfo;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    hlt_loop();
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    interrupts::init();

    println!("Hello World! Please type something below:");

    hlt_loop();
}

pub fn hlt_loop() -> ! {
    loop {
        x86_64::instructions::hlt();
    }
}
