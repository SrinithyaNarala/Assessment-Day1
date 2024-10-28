using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment_14
{
    public interface IUser
    {
        void BorrowBook();
        void ReturnBook();
        void ReserveBook() => Console.WriteLine("This user cannot reserve books.");
        void AddBook() => Console.WriteLine("This user cannot add books.");
        void RemoveBook() => Console.WriteLine("This user cannot remove books.");
    }
    public class Student : IUser
    {
        public void BorrowBook()
        {
            Console.WriteLine("Student borrows a book.");
        }
        public void ReturnBook()
        {
            Console.WriteLine("Student returns a book.");
        }
    }
    public class Teacher : IUser
    {
        public void BorrowBook()
        {
            Console.WriteLine("Teacher borrows a book.");
        }
        public void ReturnBook()
        {
            Console.WriteLine("Teacher returns a Book");
        }
        public void ReserveBook()
        {
            Console.WriteLine("Teacher reserves a book");
        }

    }
    public class Librarian : IUser
    {
        public void BorrowBook()
        {
            Console.WriteLine("Librarian borrows a book.");
        }
        public void ReturnBook()
        {
            Console.WriteLine("Librarian returns a book.");
        }
        public void AddBook()
        {
            Console.WriteLine("Librarian adds a book.");
        }
        public void RemoveBook()
        {
            Console.WriteLine("Librarian removes a book.");
        }

    }
}
