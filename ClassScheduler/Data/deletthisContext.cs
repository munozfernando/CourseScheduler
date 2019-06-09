using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models
{
    public class deletthisContext : DbContext
    {
        public deletthisContext (DbContextOptions<deletthisContext> options)
            : base(options)
        {
        }

        public DbSet<ClassScheduler.Models.Time> Time { get; set; }
    }
}
