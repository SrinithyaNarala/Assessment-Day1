using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment_14
{
    public class LibrarySystem
    {
        private readonly IUser _user;
        public LibrarySystem(IUser user)
        {
            _user = user;
        }
        public void BorrowBook()
        {
            _user.BorrowBook();
        }
        public void ReturnBook()
        {
            _user.ReturnBook();
        }
        public void ReserveBook()
        {
            _user.ReserveBook();
        }
        public void AddBook()
        {
            _user.AddBook();
        }
        public void RemoveBook()
        {
            _user.RemoveBook();
        }

    }
}
