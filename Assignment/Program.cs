using System.Text.Json;
using System.Xml.Serialization;

namespace Assignment_11
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<Author> authors = new List<Author>
            {
                new Author { AuthorId = 1, Name = "Ram", Email = "ram@gmail.com", Biography = "English novelist" },
                new Author { AuthorId = 2, Name = "Sita", Email = "sita2@gmail.com", Biography = "American writer and humorist" },
                new Author { AuthorId = 3, Name = "George", Email = "george@gmail.com", Biography = "English novelist and essayist" },
                new Author { AuthorId = 4, Name = "Abdul", Email = "abdul@gmail.com", Biography = "British author and philanthropist" },
                new Author { AuthorId = 5, Name = "Krishna", Email = "krishna12@gmail.com", Biography = "American novelist and journalist" }
            };

            List<Book> books = new List<Book>
            {
                new Book { BookId = 1, Title = "Pride and Prejudice", AuthorId = 1, Genre = "Romance", Price = 9.99 },
                new Book { BookId = 2, Title = "Adventures of Huckleberry Finn", AuthorId = 2, Genre = "Adventure", Price = 12.99 },
                new Book { BookId = 3, Title = "1984", AuthorId = 3, Genre = "Dystopian", Price = 15.99 },
                new Book { BookId = 4, Title = "Harry Potter and the Sorcerer's Stone", AuthorId = 4, Genre = "Fantasy", Price = 14.99 },
                new Book { BookId = 5, Title = "The Old Man and the Sea", AuthorId = 5, Genre = "Fiction", Price = 10.99 }
            };

            // Serialize to JSON and XML
            string authorsJsonPath = @"C:\Users\srini\Documents\Authors.json";
            string booksJsonPath = @"C:\Users\srini\Documents\Books.json";
            string authorsXmlPath = @"C:\Users\srini\Documents\Authors.xml";
            string booksXmlPath = @"C:\Users\srini\Documents\Books.xml";

            SaveListAsJson(authors, authorsJsonPath);
            SaveListAsJson(books, booksJsonPath);
            SaveListAsXml(authors, authorsXmlPath);
            SaveListAsXml(books, booksXmlPath);

            // Read and display the JSON and XML data
            ReadAndDisplayJson(authorsJsonPath);
            ReadAndDisplayJson(booksJsonPath);
            ReadAndDisplayXml(authorsXmlPath);
            ReadAndDisplayXml(booksXmlPath);
        }

        static void SaveListAsJson<T>(List<T> list, string filePath)
        {
            var json = JsonSerializer.Serialize(list, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(filePath, json);
        }

        static void SaveListAsXml<T>(List<T> list, string filePath)
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(List<T>));
            using (FileStream fs = new FileStream(filePath, FileMode.Create))
            {
                xmlSerializer.Serialize(fs, list);
            }
        }

        static void ReadAndDisplayJson(string filePath)
        {
            var json = File.ReadAllText(filePath);
            Console.WriteLine("JSON Data from" +filePath+":");
            Console.WriteLine(json);
        }

        static void ReadAndDisplayXml(string filePath)
        {
            var xml = File.ReadAllText(filePath);
            Console.WriteLine("\nXML Data" +filePath+":");
            Console.WriteLine(xml);
        }
    
    }
}
