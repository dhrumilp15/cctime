use std::io;

fn main() {
    
    println!("Welcome to Dhrumil's epic Armstrong number verifier.");
    
    println!("My regards go to Brigadier General Armstrong and Edward Elric.");
    
    loop {

        println!("Please input the Armstrong number you'd like to verify.");

        let mut str_number = String::new();

        io::stdin().read_line(&mut str_number)
            .expect("Failed to read line");
        
        let number: u32 = match str_number.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("That was not a number. Please give me the Armstrong number you'd like to verify.");
                break;
            }
        };
        
        let numlength = str_number.trim().chars().count() as u32;

        let mut armsum = 0;
        for digit in str_number.trim().chars()
        {
            const RADIX: u32 = 10;
            let digit : u32 = digit.to_digit(RADIX).unwrap();
            armsum += digit.pow(numlength);
        };

        if armsum == number
        {
            println!("True");
        } else {
            println!("False");
        }
        println!("Would you like to test more numbers? y/n");
        
        let mut again = String::new();

        io::stdin().read_line(&mut again)
            .expect("Failed to read line");

        if again.trim() == "N" || again.trim() == "n" || again.trim() == "no" || again.trim() == "No" {
            println!("Thanks for checking out my Armstrong number checker!");
            break;
        }
    }
}