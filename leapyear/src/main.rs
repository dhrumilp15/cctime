use std::io;

fn main() {
    println!("Welcome to Dhrumil's epic Leap Year validator!");

    loop {
        println!("Which year would you like to try: ");
        let mut str_year = String::new();

        io::stdin().read_line(&mut str_year)
            .expect("Failed to read line");

        let year: u32 = match str_year.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("That was not a number. Please give me the leap year you'd like to verify.");
                break;
            }
        };

        let mut flag = false;
        if year % 4 == 0 {
            flag = true;
            if year % 100 == 0 && !(year % 400 == 0) {
                flag = false;
            }
        }

        if flag == true
        {
            println!("True. This year is a leap year");
        } else {
            println!("False. This year isn't a leap year.")
        }
        
        println!("Would you like to test more years? y/n");
        
        let mut again = String::new();

        io::stdin().read_line(&mut again)
            .expect("Failed to read line");

        if again.trim() == "N" || again.trim() == "n" || again.trim() == "no" || again.trim() == "No" {
            println!("Thanks for checking out my leap year validator!");
            break;
        }
    }
    
}
