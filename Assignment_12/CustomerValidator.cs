using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Assignment_12
{
    public class CustomerValidator
    {
        public bool ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;

            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, emailPattern);
        }

        // Validates phone number to ensure it has only digits and is 10-15 characters long
        public bool ValidatePhoneNumber(string phoneNumber)
        {
            if (string.IsNullOrWhiteSpace(phoneNumber)) return false;

            string phonePattern = @"^\d{10,15}$";
            return Regex.IsMatch(phoneNumber, phonePattern);
        }

        // Validates DOB to check if customer is at least 18 years old
        public bool ValidateDateOfBirth(DateTime dateOfBirth)
        {
            int age = DateTime.Now.Year - dateOfBirth.Year;
            if (dateOfBirth > DateTime.Now.AddYears(-age)) age--; // Adjust if not yet birthday in this year
            return age >= 18;
        }
    }
}
