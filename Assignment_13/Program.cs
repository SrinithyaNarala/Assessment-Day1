using System.Collections.Generic;

namespace Assignment_13
{
    internal class Program
    {
        static void Main(string[] args)
        {
            TransportManager manager = new TransportManager();

            // Adding some sample schedules
            manager.AddSchedule(new TransportSchedule
            {
                TransportType = "bus",
                Route = "City A to City B",
                DepartureTime = new DateTime(2024, 10, 25, 9, 0, 0),
                ArrivalTime = new DateTime(2024, 10, 25, 11, 0, 0),
                Price = 20.50m,
                SeatsAvailable = 30
            });

            manager.AddSchedule(new TransportSchedule
            {
                TransportType = "flight",
                Route = "City C to City D",
                DepartureTime = new DateTime(2024, 10, 26, 14, 0, 0),
                ArrivalTime = new DateTime(2024, 10, 26, 15, 30, 0),
                Price = 150.00m,
                SeatsAvailable = 10
            });

            manager.AddSchedule(new TransportSchedule
            {
                TransportType = "bus",
                Route = "City A to City D",
                DepartureTime = new DateTime(2024, 10, 25, 8, 0, 0),
                ArrivalTime = new DateTime(2024, 10, 25, 10, 0, 0),
                Price = 18.00m,
                SeatsAvailable = 5
            });

            // Perform LINQ operations
            //Search: Find schedules by transport type, route, or time.
            var searchResults = manager.Search(transportType: "bus");
            Console.WriteLine("Search Results (Bus):");
            foreach (var schedule in searchResults)
            {
                Console.WriteLine($"{schedule.TransportType} | {schedule.Route} | {schedule.DepartureTime} | {schedule.Price}");
            }
            Console.WriteLine("\n**********************************************************************************************************************\n");
            
            //Group By: Group schedules by transport type (bus or flight).
            var groupedSchedules = manager.GroupByTransportType();
            Console.WriteLine("\nGrouped by Transport Type:");
            foreach (var group in groupedSchedules)
            {
                Console.WriteLine($"Transport Type: {group.Key}");
                foreach (var schedule in group)
                {
                    Console.WriteLine($"{schedule.Route} | {schedule.DepartureTime} | {schedule.Price}");
                }
            }
            Console.WriteLine("\n**********************************************************************************************************************\n");

            //Order By: Order schedules by departure time, price, or seats available.
            var orderedByDeparture = manager.OrderByDepartureTime();
            Console.WriteLine("\nOrdered by Departure Time:");
            foreach (var schedule in orderedByDeparture)
            {
                Console.WriteLine($"{schedule.Route} | {schedule.DepartureTime}");
            }

            Console.WriteLine ("\n**********************************************************************************************************************\n");
            
            //Filter: Filter schedules based on availability of seats or routes within a time range.
            var availableSeats = manager.FilterByAvailability(5);
            Console.WriteLine("\nFiltering Schedules with at least 5 seats available:");
            foreach (var schedule in availableSeats)
            {
                Console.WriteLine($"{schedule.Route} | {schedule.SeatsAvailable}");
            }
            
            Console.WriteLine("\n**********************************************************************************************************************\n");

            //Aggregate: Calculate the total number of available seats and the average price of transport.
            var aggregateData = manager.GetAggregatedData();
            Console.WriteLine("Seats Availability and average price:");
            Console.WriteLine($"\nTotal Seats Available: {aggregateData.totalSeats}");
            Console.WriteLine($"Average Price: {aggregateData.averagePrice:C}");

            Console.WriteLine("\n**********************************************************************************************************************\n");

        //Select: Project a list of routes and their departure times.
        var routesAndTimes = manager.SelectRoutesAndDepartureTimes();
           
            Console.WriteLine("\nList of Routes and Departure Times:");
            foreach (var (route, time) in routesAndTimes)
            {
                Console.WriteLine($"{route} | {time}");
            }
            Console.WriteLine("\n**********************************************************************************************************************\n");
        }
    }
}
