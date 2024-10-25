namespace Assignment_12
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer
            {
                Name = "Ravi Sekhar Reddy",
                Email = "ravi12gmail.com",
                PhoneNumber = "1234567890",
                DateOfBirth = new DateTime(1995, 7, 15)
            };

            CustomerValidator validator = new CustomerValidator();

            Console.WriteLine("Email valid: " + validator.ValidateEmail(customer.Email));
            Console.WriteLine("Phone Number valid: " + validator.ValidatePhoneNumber(customer.PhoneNumber));
            Console.WriteLine("Date of Birth valid: " + validator.ValidateDateOfBirth(customer.DateOfBirth));
        }
    }
}
