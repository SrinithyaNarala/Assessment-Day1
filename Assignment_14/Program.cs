namespace Assignment_14
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var student = new LibrarySystem(new Student());
            Console.WriteLine("Student operations:");
            student.BorrowBook();
            student.ReturnBook();
            student.AddBook();
            student.RemoveBook();
            student.ReserveBook(); // Student cannot reserve
            Console.WriteLine();

            var teacher = new LibrarySystem(new Teacher());
            Console.WriteLine("Teacher operations:");
            teacher.BorrowBook();
            teacher.ReturnBook();
            teacher.ReserveBook();
            teacher.AddBook(); // Teacher cannot add books
            teacher.RemoveBook();
            Console.WriteLine();

            var librarian = new LibrarySystem(new Librarian());
            Console.WriteLine("Librarian operations:");
            librarian.AddBook();
            librarian.RemoveBook();
            librarian.BorrowBook();
            librarian.ReturnBook();
            librarian.ReserveBook();

            Console.WriteLine();

            Console.ReadLine();
        }
    
    }
}
