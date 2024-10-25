using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment_13
{
    internal class TransportManager
    {
        private List<TransportSchedule> _schedules = new List<TransportSchedule>();

        // Add a schedule
        public void AddSchedule(TransportSchedule schedule)
        {
            _schedules.Add(schedule);
        }

        // Search schedules by transport type, route, or time
        public IEnumerable<TransportSchedule> Search(string transportType = null, string route = null, DateTime? time = null)
        {
            var query = _schedules.AsQueryable();

            if (!string.IsNullOrWhiteSpace(transportType))
                query = query.Where(s => s.TransportType.Equals(transportType, StringComparison.OrdinalIgnoreCase));

            if (!string.IsNullOrWhiteSpace(route))
                query = query.Where(s => s.Route.Contains(route, StringComparison.OrdinalIgnoreCase));

            if (time.HasValue)
                query = query.Where(s => s.DepartureTime.Date == time.Value.Date);

            return query.ToList();
        }

        // Group schedules by transport type
        public IGrouping<string, TransportSchedule>[] GroupByTransportType()
        {
            return _schedules.GroupBy(s => s.TransportType).ToArray();
        }

        // Order schedules by departure time
        public IEnumerable<TransportSchedule> OrderByDepartureTime()
        {
            return _schedules.OrderBy(s => s.DepartureTime).ToList();
        }

        // Order schedules by price
        public IEnumerable<TransportSchedule> OrderByPrice()
        {
            return _schedules.OrderBy(s => s.Price).ToList();
        }

        // Filter schedules based on availability of seats
        public IEnumerable<TransportSchedule> FilterByAvailability(int minSeats)
        {
            return _schedules.Where(s => s.SeatsAvailable >= minSeats).ToList();
        }

        // Aggregate the total number of available seats and average price
        public (int totalSeats, decimal averagePrice) GetAggregatedData()
        {
            int totalSeats = _schedules.Sum(s => s.SeatsAvailable);
            decimal averagePrice = _schedules.Count > 0 ? _schedules.Average(s => s.Price) : 0;

            return (totalSeats, averagePrice);
        }

        // Select routes and their departure times
        public IEnumerable<(string Route, DateTime DepartureTime)> SelectRoutesAndDepartureTimes()
        {
            return _schedules.Select(s => (s.Route, s.DepartureTime)).ToList();
        }
    }
}
