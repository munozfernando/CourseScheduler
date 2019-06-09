using System;
using ClassScheduler.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

[assembly: HostingStartup(typeof(ClassScheduler.Areas.Identity.IdentityHostingStartup))]
namespace ClassScheduler.Areas.Identity
{
    public class IdentityHostingStartup : IHostingStartup
    {
        public void Configure(IWebHostBuilder builder)
        {
            builder.ConfigureServices((context, services) => {
                services.AddDbContext<ClassSchedulerContext>(options =>
                    options.UseMySql(
                        context.Configuration.GetConnectionString("ClassSchedulerContextConnection")));

                services.AddDefaultIdentity<IdentityUser>()
                    .AddEntityFrameworkStores<ClassSchedulerContext>();
            });
        }
    }
}